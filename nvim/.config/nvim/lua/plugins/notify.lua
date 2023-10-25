return {
   "rcarriga/nvim-notify",
   opts = {
      fps = 60,
      render = "minimal",
      timeout = 500,
      top_down = true,
   },
   config = function(_, opts)
      local notify = require "notify"
      notify.setup(opts)
      vim.notify = notify
   end,
   lazy = false,
}
