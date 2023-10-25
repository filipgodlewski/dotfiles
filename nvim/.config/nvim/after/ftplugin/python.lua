local helpers = require "user.helpers"

vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

require("which-key").register({
   d = helpers.setup_dap_entrypoint,
   t = helpers.setup_neotest_mappings,
}, { prefix = "<localLeader>", buffer = 0 })
