return {
   "stevearc/conform.nvim",
   ft = {
      "c",
      "go",
      "lua",
      "md",
      "python",
      "rust",
      "toml",
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
      },
   },
}
