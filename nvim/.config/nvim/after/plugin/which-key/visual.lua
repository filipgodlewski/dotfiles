require("which-key").register({
   g = {
      name = "Global",
      y = { "\"*y", "Yank motion to system-wide register" },
   },
   ["<"] = { "<gv", "Indent left" },
   [">"] = { ">gv", "Indent right" },
   ["J"] = { ":m '>+1<CR>gv=gv", "Move highlighted lines down" },
   ["K"] = { ":m '<-2<CR>gv=gv", "Move highlighted lines up" },
},
   { mode = "v" }
)
