require("nvim-test").setup({
   silent = true,
   term = "toggleterm",
   termOpts = {
      go_back = true
   },
})

require('nvim-test.runners.pytest'):setup({
   args = { "-s", "--pdb" },
})
