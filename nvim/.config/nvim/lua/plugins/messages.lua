return {
   "AckslD/messages.nvim",
   opts = {
      command_name = "Msg",
      post_open_float = function()
         vim.opt_local.spell = false
         vim.keymap.set("n", "q", "<cmd>bw!<cr>", { buffer = true, desc = "Close" })
      end,
   },
   config = function(_, opts)
      require("messages").setup(opts)
      Msg = function(...) require("messages.api").capture_thing(...) end
   end,
}
