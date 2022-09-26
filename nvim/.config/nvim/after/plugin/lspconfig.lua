local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp

local function on_attach()
   vim.lsp.protocol.CompletionItemKind = {
      "", -- Text
      "", -- Method
      "", -- Function
      "", -- Constructor
      "", -- Field
      "", -- Variable
      "", -- Class
      "ﰮ", -- Interface
      "", -- Module
      "", -- Property
      "", -- Unit
      "", -- Value
      "", -- Enum
      "", -- Keyword
      "﬌", -- Snippet
      "", -- Color
      "", -- File
      "", -- Reference
      "", -- Folder
      "", -- EnumMember
      "", -- Constant
      "", -- Struct
      "", -- Event
      "ﬦ", -- Operator
      "", -- TypeParameter
   }

   vim.api.nvim_create_augroup("lsp_code_action", {})
end

lspconfig.pyright.setup({
   on_attach = on_attach(),
   capabilities = capabilities,
   settings = { python = { telemetry = { telemetryLevel = "off" } } },
})

lspconfig.jsonls.setup({
   on_attach = on_attach(),
   capabilities = capabilities,
   init_options = { provideFormatter = false },
})

lspconfig.dockerls.setup({
   on_attach = on_attach,
   capabilities = capabilities,
})

local function isort_cfg()
   local result = vim.fn.system("isort --show-config | jq '.sources | length'")
   if tonumber(result) == 1 then return "--settings=$XDG_CONFIG_HOME/isort/isort.cfg" end
   return ""
end

lspconfig.diagnosticls.setup({
   filetypes = { "json", "python" },
   init_options = {
      formatters = {
         hjson = { command = "hjson", args = { "-j" } },
         isort = { command = "isort", args = { isort_cfg(), "--quiet", "-" } },
         black = { command = "black", args = { "-" } },
      },
      formatFiletypes = {
         json = "hjson",
         python = { "black", "isort" }
      },
      filetypes = {
         json = "json",
         python = "flake8",
      },
      linters = {
         json = { sourceName = "json", command = "json", args = { "--validate" }, },
         flake8 = {
            sourceName = "flake8",
            command = "flake8",
            -- args = { "lint", "--format", "default" },
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
   },
})

vim.diagnostic.config({
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = true,
   severity_sort = false,
})
