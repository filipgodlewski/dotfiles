local helpers = require "user.helpers"

require("which-key").register({
   d = helpers.setup_dap_entrypoint,
}, { prefix = "<localLeader>", buffer = 0 })
