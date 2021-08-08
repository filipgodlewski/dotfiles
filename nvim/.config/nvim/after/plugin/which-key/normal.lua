require("which-key").register({
      g = {
         name = "Global",
         y = {"\"*y", "Yank motion to system-wide register"},
         Y = {"\"*Y", "Yank to EOL to system-wide register"},
      },
      ["<C-]>"] = {":lua vim.lsp.buf.definition()<CR>zz", "Go to tag"},
      ["<ESC>"] = {":noh<CR>", "Escape"},
      ["J"] = {"mzJ`z", "Join lines, cursor stays where it was"},
      ["N"] = {"Nzzzv", "Move to previous item, make view centered"},
      ["Y"] = {"\"*y$", "Yank until the end of line to system-wide register"},
      ["S"] = {"i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w", "Split line"},
      ["n"] = {"nzzzv", "Move to next item, make view centered"},
   }
)
