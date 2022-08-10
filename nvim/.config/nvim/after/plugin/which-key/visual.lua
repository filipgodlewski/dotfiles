require("which-key").register({
   g = {
      name = "Global",
      y = { "\"*y", "Yank motion to system-wide register" },
   },
   l = {
      name = "LSP",
      a = { "<CMD>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())", "Show available code action" },
   },
   ["<"] = { "<gv", "Indent left" },
   [">"] = { ">gv", "Indent right" },
   ["J"] = { ":m '>+1<CR>gv=gv", "Move highlighted lines down" },
   ["K"] = { ":m '<-2<CR>gv=gv", "Move highlighted lines up" },
},
   { mode = "v" }
)
