local pydap = require "dap-python"
local dap = require "dap"
local dapui = require "dapui"
local which_key = require "which-key"
local helpers = require "user.helpers"
local telescope = require "telescope"

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

dap.listeners.after.event_initialized["dapui_config"] = function()
   require("neotest").summary.close()
   which_key.register({
      d = {
         name = "Debug [ACTIVE]",
         c = { dap.continue, "Continue" },
         k = { dap.terminate, "Kill" },
      },
      s = {
         name = "Step [ACTIVE]",
         b = { dap.step_back, "Step back" },
         d = { dap.step_into, "Step into" },
         r = { dap.step_over, "Step over" },
         t = { dap.run_to_cursor, "To cursor" },
         u = { dap.step_out, "Step out" },
      },
      f = {
         name = "Frames [ACTIVE]",
         d = { dap.down, "Down" },
         l = { telescope.extensions.dap.frames, "List" },
         u = { dap.up, "Up" },
      },
   }, { prefix = "<leader>" })
   dapui.open {}
end

local on_event_end = function()
   helpers.deregister({ "k" }, { prefix = "<leader>d" })
   helpers.deregister({ "b", "d", "r", "t", "u" }, { prefix = "<leader>s" })
   helpers.deregister({ "d", "l", "u" }, { prefix = "<leader>f" })
   dapui.close {}
end

dap.listeners.before.event_terminated["dapui_config"] = on_event_end
dap.listeners.before.event_exited["dapui_config"] = on_event_end

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
            "breakpoints",
            "repl",
            "console",
         },
         size = 0.2,
         position = "bottom",
      },
   },
}

local delete_breakpoints = function()
   dap.clear_breakpoints()
   helpers.deregister({ "d", "l", "t" }, { prefix = "<leader>b" })
end

local setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end
   dap.set_breakpoint(cond)
   which_key.register({
      name = "Breakpoint [ACTIVE]",
      d = { delete_breakpoints, "Deactivate" },
      l = { telescope.extensions.dap.list_breakpoints, "List" },
      t = { dap.toggle_breakpoint, "Toggle" },
   }, { prefix = "<leader>b" })
end

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("DebugKeymaps", { clear = true }),
   callback = function()
      if dap.configurations[vim.api.nvim_buf_get_option(0, "filetype")] ~= nil then
         which_key.register({
            b = { name = "Breakpoint", b = { setup_breakpoint, "Set" } },
            d = { name = "Debug", c = { dap.continue, "Continue" } },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})
