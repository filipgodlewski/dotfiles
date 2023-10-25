local dap_prefix = "<localLeader>d"
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
      "rcarriga/nvim-dap-ui",
      dependencies = "mfussenegger/nvim-dap",
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
   {
      "mfussenegger/nvim-dap",
      dependencies = {
         "nvim-telescope/telescope.nvim",
         "nvim-telescope/telescope-dap.nvim",
      },
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
               k = { dap.terminate, "Kill session" },
               s = {
                  name = "Step",
                  b = { dap.step_back, "Back" },
                  d = { dap.step_into, "Into" },
                  r = { dap.step_over, "Over" },
                  t = { dap.run_to_cursor, "Continue to cursor" },
                  u = { dap.step_out, "Out" },
               },
               f = {
                  name = "Frame",
                  d = { dap.down, "Down" },
                  l = { require("telescope").extensions.dap.frames, "List all" },
                  u = { dap.up, "Up" },
               },
            }, { prefix = dap_prefix })
            require("dapui").open {}
         end

         local on_event_end = function()
            local helpers = require "user.helpers"
            -- NOTE: restricted letters for dap_prefix:
            -- "b" - breakpoint
            -- "c" - continue
            -- "k" - kill
            -- "s" - step
            -- "f" - frame
            helpers.deregister({ "d", "l", "u" }, { prefix = dap_prefix .. "f" })
            helpers.deregister({ "b", "d", "r", "t", "u" }, { prefix = dap_prefix .. "s" })
            helpers.deregister({ "k", "s", "f" }, { prefix = dap_prefix })
            require("dapui").close {}
         end

         dap.listeners.before.event_terminated["dapui_config"] = on_event_end
         dap.listeners.before.event_exited["dapui_config"] = on_event_end
      end,
   },
}
