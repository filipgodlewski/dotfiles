local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp

local function on_attach()
   vim.api.nvim_create_augroup("lsp_code_action", {})
end

lspconfig.pyright.setup({
   on_attach = on_attach,
   capabilities = capabilities,
   settings = {
      python = {
         telemetry = {
            telemetryLevel = "off"
         },
         analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "strict",
            disableOrganizeImports = true,
         }
      }
   },
})

lspconfig.jsonls.setup({
   on_attach = on_attach,
   capabilities = capabilities,
   init_options = { provideFormatter = false },
})

lspconfig.dockerls.setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

lspconfig.diagnosticls.setup({
   filetypes = { "json", "python" },
   init_options = {
      formatters = { hjson = { command = "hjson", args = { "-j" } } },
      linters = {
         json = { sourceName = "json", command = "json", args = { "--validate" }, },
         flake8 = {
            sourceName = "flake8",
            command = "flake8",
            debounce = 100,
            formatLines = 1,
            formatPattern = {
               [[^(.*\.py):(\d+):(\d+):\s([A-Z]+)\d+:?\s(.*)$]],
               {
                  sourceName = 1,
                  sourceNameFilter = true,
                  line = 2,
                  column = 3,
                  security = 4,
                  message = { "[flake8] ", 5 },
               },
            },
            securities = {
               B = 'warning',
               C = 'warning',
               W = 'warning',
               E = 'error',
               F = 'error',
               N = 'error',
               Y = 'error',
            },
         },
      },
      formatFiletypes = {
         json = "hjson",
      },
      filetypes = {
         json = "json",
         python = "flake8",
      },
   },
})

vim.diagnostic.config({
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = true,
   severity_sort = false,
})
