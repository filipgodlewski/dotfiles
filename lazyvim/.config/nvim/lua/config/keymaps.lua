local del = vim.keymap.del
local map = vim.keymap.set

local redraw_cmds = {
  "<CMD>",
  "silent! LuaSnipUnlinkCurrent<BAR>",
  "nohlsearch<BAR>",
  "diffupdate<BAR>",
  "normal! <C-L>",
  "<CR>",
}

del("n", "<leader>ur")
map("n", "<leader>ur", table.concat(redraw_cmds), { desc = "Redraw / clear hlsearch / diff update" })
