require("dap")
local dap_python = require("dap-python")
dap_python.setup('~/.local/share/venvs/nvim/bin/python')
dap_python.test_runner = 'pytest'
