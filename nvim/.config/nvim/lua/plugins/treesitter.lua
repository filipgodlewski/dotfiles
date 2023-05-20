return {
   {
      "nvim-treesitter/nvim-treesitter",
      opts = {
         ensure_installed = {
            "comment",
            "css",
            "dap_repl",
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
         highlight = {
            enable = true,
            use_languagetree = true,
         },
         indent = { enable = true },
         context_commentstring = {
            enable = true,
            enable_autocmd = false,
         },
         query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
         },
         rainbow = { enable = true },
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
         require("nvim-treesitter.install").compilers = { "gcc" }
         vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

         -- HACK: to disable in TelescopePrompt
         require("pears").setup(function(conf) conf.disabled_filetypes { "" } end)

         local treesj = require "treesj"
         treesj.setup { use_default_keymaps = false }
         require("which-key").register({
            S = { treesj.split, "Split node (TS)" },
            J = { treesj.join, "Join node (TS)" },
            T = { function() treesj.toggle { split = { recursive = true } } end, "Toggle node recursively (TS)" },
         }, { prefix = "<leader>" })
      end,
      cmd = { "TSUpdateSync", "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      event = "BufRead",
   },
   {
      "steelsojka/pears.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      lazy = true,
   },
   {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      lazy = true,
   },
}
