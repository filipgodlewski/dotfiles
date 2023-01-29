return {
   "nvim-neotest/neotest",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "nvim-neotest/neotest-python", lazy = true },
   },
   opts = function()
      return {
         adapters = {
            require "neotest-python" { dap = { justMyCode = false } },
         },
         output = { open_on_run = false },
         status = { virtual_text = false },
      }
   end,
   ft = { "python" },
   keys = { { "<leader>u", function() require("neotest").summary.toggle() end, buffer = true, desc = "Neotest" } },
}
