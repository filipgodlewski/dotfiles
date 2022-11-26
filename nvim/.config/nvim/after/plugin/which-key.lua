local which_key = require "which-key"
local gitsigns = require "gitsigns"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local trouble = require "trouble"
local neotest = require "neotest"
local dap = require "dap"
local my_helpers = require "my.helpers"
local close_buffers = require "close_buffers"

which_key.register({
   N = { function() my_helpers.put_cmd "Notifications" end, "Notifications" },
   M = { function() my_helpers.put_cmd "messages" end, "Messages" },
   -- a
   b = {
      name = "Breakpoint",
      d = { dap.clear_breakpoints, "Delete all" },
      c = { function() dap.set_breakpoint(vim.fn.input "Condition: ") end, "Conditional" },
      l = { telescope.extensions.dap.list_breakpoints, "List" },
      t = { dap.toggle_breakpoint, "Toggle" },
   },
   c = { my_helpers.search, "Quickfix" },

   d = { my_helpers.setup_debugger, "Debug" },

   -- e
   -- frames
   -- g

   h = {
      name = "Hunks",
      c = { function() vim.cmd "DiffviewClose" end, "Close diff" },
      n = { gitsigns.next_hunk, "Next hunk" },
      o = { function() vim.cmd "DiffviewOpen" end, "Open diff view" },
      p = { gitsigns.prev_hunk, "Previous hunk" },
      r = { gitsigns.reset_hunk, "Reset hunk" },
      s = { gitsigns.stage_hunk, "Stage hunk" },
      t = { function() vim.cmd "DiffviewToggleFiles" end, "Toggle Files pane" },
      u = { gitsigns.undo_stage_hunk, "Undo staging hunk" },
   },

   i = {
      name = "Inspect",
      d = { builtin.lsp_definitions, "Go to definition" },
      s = { vim.lsp.buf.hover, "Show signature" },
      t = { builtin.lsp_type_definitions, "Go to type definition" },
      u = { builtin.lsp_references, "Find Usages" },
   },

   -- j
   -- k

   l = {
      name = "Lenses",
      d = { function() trouble.toggle "document_diagnostics" end, "Document diagnostics" },
      n = { vim.diagnostic.goto_next, "Go to next diagnostic" },
      p = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
      w = { function() trouble.toggle "workspace_diagnostics" end, "Workspace diagnostics" },
   },

   -- m
   -- n

   o = { require("session-lens").search_session, "Open nvim session" },
   -- p
   q = { function() close_buffers.delete { type = "this", force = true } end, "Delete this buffer" },
   r = { vim.lsp.buf.rename, "Rename with LSP" },
   -- step
   -- t -> terminal
   u = {
      name = "Unit Test",
      d = {
         function()
            vim.cmd "wa"
            neotest.run.run { strategy = "dap" }
         end,
         "Debug nearest test",
      },
      f = {
         function()
            vim.cmd "wa"
            neotest.run.run(vim.fn.expand "%")
            neotest.summary.open()
         end,
         "Test file",
      },
      m = {
         function()
            vim.cmd "wa"
            neotest.summary.open()
            neotest.summary.run_marked()
         end,
         "Run marked tests",
      },
      r = {
         function()
            vim.cmd "wa"
            neotest.run.run()
         end,
         "Run current test",
      },
      s = { neotest.summary.toggle, "Toggle summary" },
      w = {
         function()
            local adapters = require("neotest").run.adapters()
            if #adapters == 0 then
               vim.notify "ﭧ Either no adapters or client didn't start yet"
               return
            end
            if vim.g.test_watcher == nil then
               vim.g.test_watcher = true
               neotest.summary.open()
               vim.notify "ﭧ Started test watcher"
            else
               vim.g.test_watcher = nil
               neotest.summary.close()
               vim.notify "ﭧ Stopped test watcher"
            end
         end,
         "Toggle test watcher",
      },
   },
   w = {
      function()
         vim.cmd "w"
         if vim.g.test_watcher == true and require("neotest").run.adapters() ~= {} then
            neotest.run.run(vim.fn.expand "%")
            neotest.summary.open()
         end
      end,
      "Save current buffer",
   },
   x = {
      function()
         neotest.summary.close()
         trouble.close()
         dap.terminate()
         close_buffers.delete { type = "nameless", force = true }
         vim.cmd "wa"
         vim.cmd "qa"
      end,
      "Save and close all",
   },
   -- y
   z = { telescope.extensions.file_browser.file_browser, "Browse files" },
   [","] = { builtin.buffers, "Find buffers" },
   ["."] = { builtin.resume, "Resume last search" },
   ["?"] = { builtin.help_tags, "Vim help tags" },
   ["<space>"] = { function() builtin.find_files { hidden = true } end, "Find file" },
}, { prefix = "<leader>" })

which_key.register {
   ["<ESC>"] = { ":noh<CR>:silent LuaSnipUnlinkCurrent<CR>", "Escape" },
}
