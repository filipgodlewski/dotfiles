local helpers = require "user.helpers"
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

local manage_tags = function(behavior)
   local answer = vim.fn.input(string.format("Tags to %s (empty to cancel, '?' for help): ", string.upper(behavior)))
   if answer == "" then return end
   if answer == "?" then
      vim.fn.system "open https://github.com/fatih/gomodifytags#usage"
      return
   end
   vim.cmd(string.format("GoTag%s %s", helpers.first_to_upper(behavior), answer))
end

require("which-key").register({
   name = "Exclusive to Go",
   a = { function() manage_tags "add" end, "Add tags" },
   e = { helpers.cmd "GoIfErr", "Add IfErr block" },
   r = { function() manage_tags "rm" end, "Remove tags" },
}, { prefix = "<localLeader><localLeader>", buffer = 0 })
