local gitsigns = require "gitsigns"
local t = require "telescope"
local b = require "telescope.builtin"
local trouble = require "trouble"
local dap = require "dap"
local neotest = require "neotest"

require("which-key").register({
   a = {
      name = "Debug",
      b = {
         name = "Breakpoint",
         c = { dap.clear_breakpoints, "Clear breakpoints" },
         l = { t.extensions.dap.list_breakpoints, "List breakpoints" },
         s = { function() dap.set_breakpoint(vim.fn.input "Breakpoint condition: ") end, "Set breakpoint" },
         t = { dap.toggle_breakpoint, "Toggle breakpoint" },
      },
      c = { dap.continue, "Continue" },
      d = { dap.down, "Frame down" },
      f = { t.extensions.dap.frames, "Show frames" },
      k = { dap.terminate, "Kill dap session" },
      s = {
         name = "Step",
         b = { dap.step_back, "Step back" },
         c = { dap.run_to_cursor, "Step to cursor" },
         i = { dap.step_into, "Step into" },
         o = { dap.step_over, "Step over" },
         O = { dap.step_out, "Step out" },
      },
      u = { dap.up, "Frame up" },
   },
   -- b
   -- c

   d = {
      name = "Diff",
      c = { function() vim.cmd "DiffviewClose" end, "Close diff view" },
      f = { function() vim.cmd "DiffviewFocusFiles" end, "Focus on Files pane" },
      n = { gitsigns.next_hunk, "Next hunk" },
      o = { function() vim.cmd "DiffviewOpen" end, "Open diff view" },
      p = { gitsigns.prev_hunk, "Previous hunk" },
      r = { gitsigns.reset_hunk, "Reset hunk" },
      s = { gitsigns.stage_hunk, "Stage hunk" },
      t = { function() vim.cmd "DiffviewToggleFiles" end, "Toggle Files pane" },
      u = { gitsigns.undo_stage_hunk, "Undo staging hunk" },
   },

   e = {
      name = "Errors",
      d = { function() trouble.toggle "document_diagnostics" end, "Document diagnostics" },
      n = { vim.diagnostic.goto_next, "Go to next diagnostic" },
      p = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
      w = { function() trouble.toggle "workspace_diagnostics" end, "Workspace diagnostics" },
   },

   -- f
   -- g
   -- h

   i = {
      name = "Inspect",
      d = { b.lsp_definitions, "Go to definition" },
      s = { vim.lsp.buf.hover, "Show signature" },
      t = { b.lsp_type_definitions, "Go to type definition" },
      u = { b.lsp_references, "Find Usages" },
   },
   -- j
   -- k
   l = { gitsigns.blame_line, "Show blame for the current line" },
   -- m

   n = { function() vim.cmd "bn" end, "Go to next buffer" },
   o = { require("session-lens").search_session, "Open nvim session" },
   p = { function() vim.cmd "bp" end, "Go to previous buffer" },
   q = { function() require("close_buffers").delete { type = "this", force = true } end, "Delete this buffer" },
   r = {
      name = "Refactor",
      r = { vim.lsp.buf.rename, "Rename with LSP" },
   },
   s = { function() b.live_grep { hidden = true } end, "Search text occurrence" },
   -- t
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
   v = { b.help_tags, "Vim help tags" },
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
         dap.terminate()
         vim.cmd "wa"
         vim.cmd "qa"
      end,
      "Save and close all",
   },
   -- y
   z = { t.extensions.file_browser.file_browser, "Browse files" },
   [","] = { b.buffers, "Find buffers" },
   ["."] = { b.resume, "Resume last search" },
   ["?"] = {
      function() vim.cmd [[15new +put\ =\ execute('messages')|set\ nornu\ nonu]] end,
      "Open messages in a split buffer",
   },
   ["!"] = { function() vim.cmd "bd!" end, "Force close buffer" },
   ["<space>"] = { function() b.find_files { hidden = true } end, "Find file" },
}, { prefix = "<leader>" })
