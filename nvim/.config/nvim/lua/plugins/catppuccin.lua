return {
   "catppuccin/nvim",
   name = "catppuccin",
   opts = {
      flavour = "macchiato",
      integrations = {
         hop = true,
         notify = true,
         fidget = true,
         dap = {
            enabled = true,
            enable_ui = true,
         },
         lsp_trouble = true,
         mason = true,
         neotest = true,
         semantic_tokens = true,
      },
   },
   config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
   end,
}
