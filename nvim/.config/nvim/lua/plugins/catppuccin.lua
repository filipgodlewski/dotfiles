return {
   "catppuccin/nvim",
   name = "catppuccin",
   opts = {
      flavour = "macchiato",
      integrations = {
         notify = true,
         fidget = true,
         dap = {
            enabled = true,
            enable_ui = true,
         },
         mason = true,
         neotest = true,
         semantic_tokens = true,
      },
   },
   config = true,
}
