local lspconfig = require "lspconfig"

local global_opts = {
   capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
   autostart = true,
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
         workspace = { library = vim.api.nvim_get_runtime_file("", true) },
         formatting = { enable = false },
      },
   },
})

vim.diagnostic.config {
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = true,
   severity_sort = false,
}
