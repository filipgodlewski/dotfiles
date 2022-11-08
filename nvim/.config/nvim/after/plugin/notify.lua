local notify = require "notify"
vim.notify = notify
notify.setup {
   fps = 60,
   render = "minimal",
   timeout = 1000,
   top_down = false,
}
