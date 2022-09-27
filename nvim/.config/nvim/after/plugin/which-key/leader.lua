require("which-key").register({
   H = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", "Find help tags" },
   R = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename with LSP" },

   b = { "<CMD>lua require('gitsigns').blame_line(full=true)<CR>", "Show blame for current line" },

   c = {
      name = "Compare",
      O = { "<CMD>DiffviewOpen ", "Open diff view (insert ready)" },
      o = { "<CMD>DiffviewOpen<CR>", "Open diff view" },
      c = { "<CMD>DiffviewClose<CR>", "Close diff view" },
      r = { "<CMD>DiffviewRefresh<CR>", "Refresh diff view" },
      h = { "<CMD>DiffviewFilesHistory<CR>", "Open file history diff view" },
      t = { "<CMD>DiffviewToggleFiles<CR>", "Toggle Files pane" },
      f = { "<CMD>DiffviewFocusFiles<CR>", "Focus on Files pane" },
   },

   d = { "<CMD>lua require('telescope.builtin').lsp_definitions({ jump_type='never' })<CR>", "Show definition" },

   e = {
      name = "Errors",
      d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
      n = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      p = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
      w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
   },

   f = { "<CMD>lua vim.lsp.buf.formatting_sync()<CR><CMD>w<CR>", "Format code" },

   g = {
      name = "Git",
      b = { "<CMD>lua require('telescope.builtin').git_branches()<CR>", "Perform actions on git branches" },
      c = { "<CMD>lua require('telescope.builtin').git_commits()<CR>", "Checkout on selected commit" },
      s = { "<CMD>lua require('telescope.builtin').git_status()<CR>", "List git status for current directory" },
      t = { "<CMD>lua require('telescope.builtin').git_stash()<CR>",
         "Search through stashes with an option to apply them" },
   },

   h = {
      name = "Hunks",
      R = { "<CMD>lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
      d = { "<CMD>lua require('gitsigns').toggle_deleted()<CR>", "Show deleted lines" },
      p = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
      r = { "<CMD>lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
      s = { "<CMD>lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
      u = { "<CMD>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo staging hunk" },
   },

   k = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Show documentation" },
   n = { "<CMD>bn<CR>", "Go to next buffer" },
   p = { "<CMD>bp<CR>", "Go to previous buffer" },
   q = { "<CMD>lua require('close_buffers').delete({ type='this' })<CR>", "Delete this buffer" },
   r = { "<CMD>lua require('telescope.builtin').oldfiles()<CR>", "Find recent file" },
   s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Open signature help" },
   t = { "<CMD>lua require('telescope.builtin').live_grep({ hidden=true })<CR>", "Find text occurrence" },
   u = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Find Usages" },
   w = { "<CMD>wa<CR>", "Save all" },
   x = { "<CMD>xa<CR>", "Save and close all" },
   [","] = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Find buffers" },
   ["/"] = { "<CMD>ToggleTerm<CR>", "Toggle last terminal" },
   ["<space>"] = { "<CMD>lua require('telescope.builtin').find_files({ hidden=true })<CR>", "Find file" },
},

   { prefix = "<leader>" }
)
