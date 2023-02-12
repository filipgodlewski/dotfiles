return {
   "akinsho/nvim-toggleterm.lua",
   opts = {
      shade_terminals = false,
      start_in_insert = true,
      open_mapping = [[<M-t>]],
      on_create = function(_) vim.opt_local.spell = false end,
      insert_mappings = false,
      autochdir = true,
      direction = "float",
      float_opts = {
         height = function() return math.floor(vim.api.nvim_win_get_height(0) * 0.8) end,
         width = function() return math.min(math.floor(vim.o.columns * 0.9), 120) end,
         winblend = 0,
      },
   },
   keys = {
      { "<M-t>" },
   },
}
