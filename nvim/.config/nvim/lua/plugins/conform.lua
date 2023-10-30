return {
   "stevearc/conform.nvim",
   ft = {
      "c",
      "go",
      "json",
      "lua",
      "md",
      "python",
      "rust",
      "toml",
      "yaml",
   },
   opts = {
      formatters_by_ft = {
         c = { "clang_format" },
         go = { "gofumpt", "goimports_reviser" },
         json = { "fixjson" },
         lua = { "stylua" },
         markdown = { "markdownlint" },
         python = { "auto_optional", "black", "ruff_fix" },
         rust = { "rustfmt" },
         toml = { "taplo" },
         yaml = { "yamlfix" },
      },
      format_on_save = {
         lsp_fallback = true,
         async = false,
         timeout_ms = 1000,
      },
      formatters = {
         auto_optional = {
            command = "auto-optional",
            args = { "$FILENAME" },
            stdin = false,
         },
         rustfmt = {
            args = function()
               local Path = require "plenary.path"
               local cargo_toml = Path:new(vim.fn.getcwd() .. "/Cargo.toml")

               local edition = "--edition=2021"
               if cargo_toml:exists() and cargo_toml:is_file() then
                  for _, line in ipairs(cargo_toml:readlines()) do
                     local year = line:match [[^edition%s*=%s*%"(%d+)%"]]
                     if year then
                        edition = "--edition=" .. year
                        break
                     end
                  end
               end
               return { "--emit=stdout", edition }
            end,
         },
      },
   },
}
