require("nvim-treesitter.configs").setup {
   ensure_installed = {
      "comment",
      "css",
      "html",
      "json",
      "lua",
      "python",
      "regex",
      "rust",
      "scss",
      "toml",
      "yaml",
   },
   highlight = { enable = true },
   context_commentstring = { enable = true },
   query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
   },
}
