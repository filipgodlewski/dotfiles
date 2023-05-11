return {
   "mfussenegger/nvim-dap",
   dependencies = {
      "mfussenegger/nvim-dap-python",
      {
         "rcarriga/nvim-dap-ui",
         opts = {
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
         },
      },
   },
   ft = { "python" },
   config = function()
      local dap = require "dap"
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })

      dap.listeners.after.event_initialized["dapui_config"] = function()
         require("neotest").summary.close()
         require("which-key").register({
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
               l = { require("telescope").extensions.dap.frames, "List" },
               u = { dap.up, "Up" },
            },
         }, { prefix = "<leader>" })
         require("dapui").open {}
      end

      local on_event_end = function()
         local helpers = require "user.helpers"
         helpers.deregister({ "k" }, { prefix = "<leader>d" })
         helpers.deregister({ "b", "d", "r", "t", "u" }, { prefix = "<leader>s" })
         helpers.deregister({ "d", "l", "u" }, { prefix = "<leader>f" })
         require("dapui").close {}
      end

      dap.listeners.before.event_terminated["dapui_config"] = on_event_end
      dap.listeners.before.event_exited["dapui_config"] = on_event_end

      dap.configurations.python = {}

      local debupy_path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(debupy_path)
      require("dap-python").test_runner = "pytest"
   end,
}
