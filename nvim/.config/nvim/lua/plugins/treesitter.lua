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
         require("nvim-treesitter.install").compilers = { "gcc-12" }
         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end,
      cmd = "TSUpdateSync",
   },
   {
      "nvim-treesitter/playground",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      cmd = "TSPlaygroundToggle",
   },
   {
      "m-demare/hlargs.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = true,
      event = "BufAdd",
   },
   {
      "RRethy/vim-illuminate",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = { min_count_to_highlight = 2 },
      config = function(_, opts) require("illuminate").configure(opts) end,
      event = "BufAdd",
   },
}
