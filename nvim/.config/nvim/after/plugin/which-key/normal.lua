require("which-key").register {
   g = {
      name = "Global",
      y = { '"*y', "Yank motion to system-wide register" },
      Y = { '"*Y', "Yank to EOL to system-wide register" },
   },
   z = {
      ["="] = { "<CMD>lua require('telescope.builtin').spell_suggest()<CR>", "Spelling suggestions " },
   },
   ["<ESC>"] = { ":noh<CR>:silent LuaSnipUnlinkCurrent<CR>", "Escape" },
   ["J"] = { "mzJ`z", "Join lines, cursor stays where it was" },
   ["N"] = { "Nzzzv", "Move to previous item, make view centered" },
   ["S"] = { "i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w", "Split line" },
   ["n"] = { "nzzzv", "Move to next item, make view centered" },
}
