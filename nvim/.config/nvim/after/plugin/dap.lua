local pydap = require "dap-python"
local dap = require "dap"
local dapui = require "dapui"

local dap_signs = {
   DapBreakpoint = "DiagnosticVirtualTextInfo",
   DapLogPoint = "DiagnosticVirtualTextHint",
   DapBreakpointRejected = "DiagnosticVirtualTextError",
   DapBreakpointCondition = "DiagnosticVirtualTextWarn",
}

for key, color in pairs(dap_signs) do
   vim.fn.sign_define(key, { text = "", texthl = color, linehl = color, numhl = color })
end

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

dap.configurations.python = {}

local debupy_path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
pydap.setup(debupy_path)
pydap.test_runner = "pytest"

dapui.setup()
