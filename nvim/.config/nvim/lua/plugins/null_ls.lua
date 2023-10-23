return {
   "jose-elias-alvarez/null-ls.nvim",
   opts = function()
      local null_ls = require "null-ls"
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local on_save = function(bufnr)
         vim.lsp.buf.format {
            bufnr = bufnr,
            timeout_ms = 2000,
            filter = function(client) return client.name == "null-ls" end,
         }
      end

      local on_attach = function(client, bufnr)
         if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
               group = augroup,
               buffer = bufnr,
               callback = function() on_save(bufnr) end,
            })
         end
      end

      return {
         on_attach = on_attach,
         sources = {
            {
               method = null_ls.methods.FORMATTING,
               filetypes = { "python" },
               generator = null_ls.formatter {
                  command = "auto-optional",
                  args = { "$FILENAME" },
                  to_stdin = false,
                  format = nil,
                  to_temp_file = true,
                  from_temp_file = true,
               },
            },
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.ruff.with {
               extra_args = function(_) return { "--select", "I001" } end,
            },
            null_ls.builtins.formatting.fixjson,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.taplo,
            null_ls.builtins.diagnostics.markdownlint,
            null_ls.builtins.formatting.rustfmt.with {
               extra_args = function(params)
                  local cargo_toml = require("plenary.path"):new(params.root .. "/" .. "Cargo.toml")
                  if cargo_toml:exists() and cargo_toml:is_file() then
                     for _, line in ipairs(cargo_toml:readlines()) do
                        local edition = line:match [[^edition%s*=%s*%"(%d+)%"]]
                        if edition then return { "--edition=" .. edition } end
                     end
                  end
                  return { "--edition=2021" }
               end,
            },
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.goimports_reviser,
         },
      }
   end,
   ft = {
      "c",
      "go",
      "lua",
      "md",
      "python",
      "rust",
      "toml",
   },
   cmd = { "LspRestart", "LspStart", "LspStop", "LspLog", "LspInstall", "LspUninstall" },
   dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason-lspconfig.nvim",
   },
}
