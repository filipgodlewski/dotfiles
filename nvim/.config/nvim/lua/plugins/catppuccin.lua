return {
   "catppuccin/nvim",
   name = "catppuccin",
   opts = {
      flavour = "macchiato",
      integrations = {
         cmp = true,
         dap = { enabled = true, enable_ui = true },
         fidget = true,
         lsp_trouble = true,
         markdown = true,
         mason = true,
         native_lsp = { enabled = true },
         neotest = true,
         notify = true,
         semantic_tokens = true,
         treesitter = true,
         treesitter_context = true,
         which_key = true,
      },
   },
   config = true,
}
