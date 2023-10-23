return {
   {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = "mfussenegger/nvim-dap",
      config = function()
         require("dap").configurations.python = {}
         local debugpy = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
         require("dap-python").setup(debugpy)
         require("dap-python").test_runner = "pytest"
      end,
   },
   {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = "mfussenegger/nvim-dap",
      config = true,
   },
   {
      "mfussenegger/nvim-dap",
      dependencies = {
         "nvim-telescope/telescope.nvim",
         "nvim-telescope/telescope-dap.nvim",
         {
            "rcarriga/nvim-dap-ui",
            opts = {
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
      ft = { "python", "go" },
      init = function()
         local dap = require "dap"
         local sign = vim.fn.sign_define
         sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
         sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
         sign("DapLogPoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })

         dap.listeners.after.event_initialized["dapui_config"] = function()
            require("neotest").summary.close()
            require("telescope").load_extension "dap"
            require("which-key").register({
               k = { dap.terminate, "Kill debugger" },
               s = {
                  name = "Step",
                  b = { dap.step_back, "Step back" },
                  d = { dap.step_into, "Step into" },
                  r = { dap.step_over, "Step over" },
                  t = { dap.run_to_cursor, "Continue to cursor" },
                  u = { dap.step_out, "Step out" },
               },
               f = {
                  name = "Frames",
                  d = { dap.down, "Go frame down" },
                  l = { require("telescope").extensions.dap.frames, "List all frames" },
                  u = { dap.up, "Go frame up" },
               },
            }, { prefix = "<localLeader>" })
            require("dapui").open {}
         end

         local on_event_end = function()
            local helpers = require "user.helpers"
            helpers.deregister({ "d", "l", "u" }, { prefix = "<localLeader>f" })
            helpers.deregister({ "l", "t" }, { prefix = "<localLeader>r" })
            helpers.deregister({ "b", "d", "r", "t", "u" }, { prefix = "<localLeader>s" })
            helpers.deregister({ "k", "s", "f", "r" }, { prefix = "<localLeader>" })
            require("dapui").close {}
         end

         dap.listeners.before.event_terminated["dapui_config"] = on_event_end
         dap.listeners.before.event_exited["dapui_config"] = on_event_end
      end,
   },
}
