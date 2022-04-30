require("nvim-autopairs").setup({
   check_ts = true,
   enable_check_bracket_line = true,
   fast_wrap = {
      map = "<C-s>",
      keys =  "abcdefghijklmnoprstuvwxyz",
      highlight =  "MatchParen",
   },
})
