require("trouble").setup({
   icons = false,
   fold_open = "v",
   fold_closed = ">",
   indent_lines = false,
   signs = {
      error = "x",
      warning = "!",
      hint = "?",
      information = "i",
      other = "-",
   },
   use_diagnostic_signs = false,
})
