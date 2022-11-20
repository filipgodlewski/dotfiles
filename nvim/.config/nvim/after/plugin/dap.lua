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
local color = "DiffChange"
vim.fn.sign_define("DapStopped", { text = "ﰲ", texthl = color, linehl = color, numhl = color })

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

dap.configurations.python = {}

local debupy_path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
pydap.setup(debupy_path)
pydap.test_runner = "pytest"

dapui.setup {
   icons = {
      expanded = "",
      collapsed = "",
      current_frame = "",
   },
   layouts = {
      {
         elements = {
            { id = "scopes", size = 0.4 },
            { id = "stacks", size = 0.4 },
            { id = "watches", size = 0.2 },
         },
         size = 50,
         position = "right",
      },
      {
         elements = {
            { id = "breakpoints", size = 0.2 },
            { id = "repl", size = 0.5 },
            "console",
         },
         size = 0.2,
         position = "bottom",
      },
   },
}
