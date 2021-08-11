require("toggleterm").setup({
   shading_factor = "1",
   start_in_insert = false,
   float_opts = {
      border = "curved",
      width = function() return math.floor(vim.o.columns * 0.65) end,
      height = function() return math.floor(vim.o.lines * 0.5) end,
   },
})

local Terminal = require("toggleterm.terminal").Terminal

local regularTerm = Terminal:new {
   count = 1,
   direction = "horizontal",
   dir = "git_dir",
}

function RegularTerm_toggle()
   regularTerm:toggle()
end

local bpython = Terminal:new {
   count = 2,
   cmd = "bpython",
   direction = "float",
   dir = "git_dir",
   on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", ":ToggleTerm<CR>", {noremap = true, silent = true})
   end,
}

function Python_toggle()
   bpython:toggle()
end
