local lspconfig = require "lspconfig"
local which_key = require "which-key"
local trouble = require "trouble"
local builtin = require "telescope.builtin"
require("mason").setup()
require("mason-tool-installer").setup {
   ensure_installed = {
      "black",
      "codelldb",
      "css-lsp",
      "debugpy",
      "dockerfile-language-server",
      "fixjson",
      "flake8",
      "isort",
      "json-lsp",
      "lua-language-server",
      "markdownlint",
      "marksman",
      "pyright",
      "rust-analyzer",
      "stylua",
      "taplo",
      "yaml-language-server",
   },
   auto_update = true,
}

local global_opts = {
   capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
   on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end
   end,
}

require("mason-lspconfig").setup_handlers {
   function(server_name) require("lspconfig")[server_name].setup(global_opts) end,
}

local setup = function(server, custom_opts)
   local opts = vim.tbl_deep_extend("force", global_opts, custom_opts or {})
   lspconfig[server].setup(opts)
end

setup("pyright", {
   settings = {
      python = {
         telemetry = {
            telemetryLevel = "off",
         },
         analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "strict",
            disableOrganizeImports = true,
         },
      },
   },
})

setup("jsonls", { init_options = { provideFormatter = false } })
setup("sumneko_lua", {
   settings = {
      Lua = {
         runtime = { version = "luaJIT" },
         diagnostics = { globals = { "vim" } },
         workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
         },
         formatting = { enable = false },
      },
   },
})

vim.diagnostic.config {
   virtual_text = false,
   signs = false,
   severity_sort = true,
   float = false,
}

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
   callback = function()
      if not vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
         which_key.register({
            i = {
               name = "Inspect",
               d = { builtin.lsp_definitions, "Definition" },
               s = { vim.lsp.buf.hover, "Signature" },
               t = { builtin.lsp_type_definitions, "Type definition" },
               u = { builtin.lsp_references, "Usages" },
            },
            l = {
               name = "Lenses",
               d = { function() trouble.toggle "document_diagnostics" end, "Document" },
               n = { vim.diagnostic.goto_next, "Next" },
               p = { vim.diagnostic.goto_prev, "Previous" },
               w = { function() trouble.toggle "workspace_diagnostics" end, "Workspace" },
            },
            r = { vim.lsp.buf.rename, "Rename" },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})
