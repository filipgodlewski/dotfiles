return {
   {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {},
      opts = {
         ensure_installed = {
            "comment",
            "css",
            "gitcommit",
            "gitignore",
            "html",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "scss",
            "sql",
            "toml",
            "yaml",
         },
         highlight = { enable = true },
         context_commentstring = {
            enable = true,
            enable_autocmd = false,
         },
         query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
         },
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
         require("nvim-treesitter.install").compilers = { "gcc" }
         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end,
      cmd = "TSUpdateSync",
   },
}
