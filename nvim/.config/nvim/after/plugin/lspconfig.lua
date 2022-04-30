local lspconfig = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local capabilities = protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach()
   protocol.CompletionItemKind = {
     '', -- Text
     '', -- Method
     '', -- Function
     '', -- Constructor
     '', -- Field
     '', -- Variable
     '', -- Class
     'ﰮ', -- Interface
     '', -- Module
     '', -- Property
     '', -- Unit
     '', -- Value
     '', -- Enum
     '', -- Keyword
     '﬌', -- Snippet
     '', -- Color
     '', -- File
     '', -- Reference
     '', -- Folder
     '', -- EnumMember
     '', -- Constant
     '', -- Struct
     '', -- Event
     'ﬦ', -- Operator
     '', -- TypeParameter
   }
end

local servers = {"ccls", "jedi_language_server", "jsonls", "denols", "pyright", "sqlls"}

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach(),
      capabilities = cmp_capabilities,
}
end

lspconfig.pyright.setup({
   on_attach = function(client) client.server_capabilities.completionProvider = false end
})

lspconfig.sqlls.setup({
   cmd = {"/usr/local/bin/sql-language-server", "up", "--method", "stdio"}
})

local function isort_cfg()
   local result = vim.fn.system("isort --show-config | jq '.sources | length'")
   local result = tonumber(result)
   if result == 1 then
      return "--settings=$XDG_CONFIG_HOME/isort/isort.cfg" 
   else 
      return "" 
   end
end

lspconfig.diagnosticls.setup({
   on_attach = on_attach,
   capabilities = capabilities,
   filetypes = {"json", "python"},

   init_options = {

      formatters = {

         hjson = {
            command = "hjson",
            args = {"-j"},
         },

         isort = {
            command = "isort",
            args = {isort_cfg(), "--quiet", "-"},
         },

         yapf = {
            command = "yapf",
            args = {"-q"},
         }

      },

      formatFiletypes = {
         json = "hjson",
         python = {"yapf", "isort"},
      },

      filetypes = {
         json = {"json"},
         python = {"pyright", "flake8"},
      },

      linters = {

         json = {
            sourceName = "json",
            command = "json",
            args = {"--validate"},
         },

         -- pyre = {
         --    sourceName = "pyre",
         --    command = "pyre",
         --    args = {"--strict"},
         --    requiredFiles = {".pyre_configuration"},
         --    rootPatterns = {".pyre_configuration"},
         --    debounce = 100,
         --    formatLines = 1,
         --    formatPattern = {
         --       [[^(.*\.py):(\d+):(\d+)\s(.*)\.$]],
         --       {
         --          sourceName = 1,
         --          sourceNameFilter = true,
         --          line = 2,
         --          column = 3,
         --          message = 4,
         --       },
         --    },
         -- },

         flake8 = {
            sourceName = 'flake8',
            command = 'flake8',
            -- requiredFiles = {'.flake8', 'setup.cfg', 'tox.ini'},
            -- rootPatterns = {'.flake8', 'setup.cfg', 'tox.ini'},
            debounce = 100,
            formatLines = 1,
            formatPattern = {
               [[^(.*\.py):(\d+):(\d+):\s([a-zA-Z]+)\d+:?\s(.*)$]],
               {
                  sourceName = 1,
                  sourceNameFilter = true,
                  line = 2,
                  column = 3,
                  security = 4,
                  message = 5,
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

         pyright = {
            command = "pyright",
            sourceName = "pyright",
            args = {"%file"},
            debounce = 1000,
            offsetLine = 0,
            offsetColumn = 2,
            formatLines = 1,
            formatPattern = {
               [[(\/.*\.py):(\d+):(\d+) - (\w+): (.*) \((\w+)\)$]],
               {
                  sourceName = 1,
                  sourceNameFilter = true,
                  line = 2,
                  column = 3,
                  security = 4,
                  message = 5,
               },
            },
            securities = {
               error = "error",
               warning = "warning",
               information = "info",
            },
         },
      },
   },
})

lspconfig.jsonls.setup({
   init_options = {
      provideFormatter = false,
   }
})

lspconfig.ccls.setup{
   init_options = {
      compilationDatabaseDirectory = "build",
      index = {
         threads = 0,
      },
      clang = {
         extraArgs = {
            "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
            "-isysroot/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
         },
         excludeArgs = {"-frounding-math"},
      },
   }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      spacing = 4,
   },
   update_in_insert = true,
 }
)
