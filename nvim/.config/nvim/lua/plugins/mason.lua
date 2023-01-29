local configs = {
   pyright = {
      settings = {
         python = {
            telemetry = {
               telemetryLevel = "off",
            },
            analysis = {
               autoSearchPaths = true,
               diagnosticMode = "workspace",
               useLibraryCodeForTypes = true,
               disableOrganizeImports = true,
               typeCheckingMode = "strict",
            },
         },
      },
   },

   jsonls = { init_options = { provideFormatter = false } },

   sumneko_lua = {
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
   },
}

return {
   "williamboman/mason.nvim",
   name = "mason",
   dependencies = {
      {
         "WhoIsSethDaniel/mason-tool-installer.nvim",
         opts = {
            ensure_installed = {
               "black",
               "codelldb",
               "css-lsp",
               "debugpy",
               "dockerfile-language-server",
               "fixjson",
               -- "flake8",
               -- "isort",
               "json-lsp",
               "lua-language-server",
               "markdownlint",
               "marksman",
               "pyright",
               "ruff",
               "stylua",
               "taplo",
               "yaml-language-server",
            },
            auto_update = true,
         },
      },
      {
         "williamboman/mason-lspconfig.nvim",
         dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "SmiteshP/nvim-navic",
         },
         name = "mason-lspconfig",
         lazy = true,
         config = function(plugin)
            local global_opts = {
               capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
               on_attach = function(client, bufnr)
                  if client.server_capabilities.documentSymbolProvider then
                     require("nvim-navic").attach(client, bufnr)
                  end
               end,
            }

            local setup_override = function(server_name)
               require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", global_opts, configs[server_name]))
            end

            require(plugin.name).setup_handlers {
               function(server_name) require("lspconfig")[server_name].setup(global_opts) end,
               pyright = function() setup_override "pyright" end,
               jsonls = function() setup_override "jsonls" end,
               sumneko_lua = function() setup_override "sumneko_lua" end,
            }
         end,
      },
      { "RubixDev/mason-update-all", config = true },
   },
   config = function(plugin)
      require(plugin.name).setup()
      require("mason-lspconfig").setup()
   end,
}
