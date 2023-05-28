return {
   "nvim-neotest/neotest",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
   },
   opts = function()
      return {
         adapters = {
            require "neotest-python" { dap = { justMyCode = true } },
         },
         output = { open_on_run = false },
         status = { virtual_text = false },
      }
   end,
}
