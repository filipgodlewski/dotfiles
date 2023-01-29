return {
   {
      "nvim-treesitter/nvim-treesitter",
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
         require("nvim-treesitter.install").compilers = { "gcc-12" }
      end,
      dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
   },
   {
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
   },
   {
      "m-demare/hlargs.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = true,
   },
}
