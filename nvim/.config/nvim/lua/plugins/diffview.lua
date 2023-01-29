return {
   "sindrets/diffview.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   opts = {
      hooks = {
         view_opened = function() vim.keymap.set("n", "<leader>d", "<cmd>DiffviewClose<cr>", { desc = "Diff Close" }) end,
      },
   },
   cmd = { "DiffviewOpen", "DiffviewFileHistory" },
}
