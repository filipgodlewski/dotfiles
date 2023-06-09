local get_total_height = function() return vim.o.lines - vim.o.cmdheight end
local get_total_width = function() return vim.o.columns end
local get_min_size = function(multiplicand, alternative) return math.floor((math.min(0.5 * multiplicand, alternative))) end

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
         height = function() return get_min_size(get_total_height(), 40) end,
         width = function() return get_min_size(get_total_width(), 150) end,
         winblend = 0,
      },
   },
   keys = "<M-t>",
}
