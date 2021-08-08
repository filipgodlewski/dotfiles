require("nvim-autopairs").setup({
   fast_wrap = {
      map = "<C-s>",
      keys =  "abcdefghijklmnoprstuvwxyz",
      highlight =  "MatchParen",
   },
})

require("nvim-autopairs.completion.compe").setup({
   map_cr = true,
   map_complete = true,
})
