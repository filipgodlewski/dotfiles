local lspconfig = require "lspconfig"
local which_key = require "which-key"
local trouble = require "trouble"
local builtin = require "telescope.builtin"
local my_helpers = require "my.helpers"

local global_opts = {
   capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
   autostart = true,
   on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end
   end,
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

vim.diagnostic.config { virtual_text = false, update_in_insert = false, signs = false }

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
   callback = function()
      if vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
         my_helpers.deregister({ "d", "s", "t", "u" }, { prefix = "<leader>i" })
         my_helpers.deregister({ "d", "n", "p", "w" }, { prefix = "<leader>l" })
         my_helpers.deregister({ "i", "l", "r" }, { prefix = "<leader>" })
      else
         which_key.register({
            i = {
               name = "Inspect",
               d = { builtin.lsp_definitions, "Go to definition" },
               s = { vim.lsp.buf.hover, "Show signature" },
               t = { builtin.lsp_type_definitions, "Go to type definition" },
               u = { builtin.lsp_references, "Find Usages" },
            },
            l = {
               name = "Lenses",
               d = { function() trouble.toggle "document_diagnostics" end, "Document diagnostics" },
               n = { vim.diagnostic.goto_next, "Go to next diagnostic" },
               p = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
               w = { function() trouble.toggle "workspace_diagnostics" end, "Workspace diagnostics" },
            },
            r = { vim.lsp.buf.rename, "Rename" },
         }, { prefix = "<leader>" })
      end
   end,
})
