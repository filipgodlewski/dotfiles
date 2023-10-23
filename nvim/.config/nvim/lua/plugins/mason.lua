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
               executionEnvironments = {
                  { root = "code" },
               },
            },
            workspace = {
               didChangeWatchedFiles = {
                  dynamicRegistration = true,
               },
            },
         },
      },
   },

   jsonls = { init_options = { provideFormatter = false } },

   lua_ls = {
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

   gopls = {
      settings = {
         gpls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
               unusedparams = true,
            },
         },
      },
   },
}

return {
   {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      config = true,
      lazy = false,
   },
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
         ensure_installed = {
            "black",
            "clang-format",
            "clangd",
            "codelldb",
            "css-lsp",
            "debugpy",
            "delve",
            "dockerfile-language-server",
            "fixjson",
            "gopls",
            "gofumpt",
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
         run_on_start = false,
      },
      cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
   },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
         "williamboman/mason.nvim",
         "neovim/nvim-lspconfig",
         "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
         require("mason-lspconfig").setup()

         local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities() or {}
         )
         capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
         local global_opts = {
            capabilities = capabilities,
            on_attach = function(_, bufnr)
               vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
               vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
               vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
            end,
         }

         local setup_override = function(server_name)
            require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", global_opts, configs[server_name]))
         end

         require("mason-lspconfig").setup_handlers {
            function(server_name) require("lspconfig")[server_name].setup(global_opts) end,
            pyright = function() setup_override "pyright" end,
            jsonls = function() setup_override "jsonls" end,
            lua_ls = function() setup_override "lua_ls" end,
            gopls = function() setup_override "gopls" end,
         }

         vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = false,
            signs = false,
            severity_sort = true,
            float = false,
         }
      end,
   },
}
