require("which-key").register({
   H = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", "Find help tags" },
   R = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename with LSP" },

   b = { "<CMD>lua require('gitsigns').blame_line()<CR>", "Show blame for current line" },

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

   d = {
      name = "Def",
      d = { "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", "Go to definition" },
      s = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Show signature" },
      t = { "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", "Go to type definition" },
      u = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Find Usages" },
   },

   e = {
      name = "Errors",
      d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
      n = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      p = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
      w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
   },

   f = { "<CMD>lua vim.lsp.buf.format()<CR>", "Format code" },

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
      D = { "<CMD>lua require('gitsigns').diffthis()<CR>", "Diff this buffer" },
      R = { "<CMD>lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
      S = { "<CMD>lua require('gitsigns').stage_buffer()<CR>", "Stage buffer" },
      d = { "<CMD>lua require('gitsigns').toggle_deleted()<CR>", "Show deleted lines" },
      h = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
      l = { "<CMD>lua require('gitsigns').toggle_linehl()<CR>", "Show hunks as line highlights" },
      n = { "<CMD>lua require('gitsigns').next_hunk()<CR>", "Next hunk" },
      p = { "<CMD>lua require('gitsigns').prev_hunk()<CR>", "Previous hunk" },
      r = { "<CMD>lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
      s = { "<CMD>lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
      u = { "<CMD>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo staging hunk" },
   },

   n = { "<CMD>bn<CR>", "Go to next buffer" },
   p = { "<CMD>bp<CR>", "Go to previous buffer" },
   q = { "<CMD>lua require('close_buffers').delete({ type='this' })<CR>", "Delete this buffer" },
   r = { "<CMD>lua require('telescope.builtin').oldfiles()<CR>", "Open recent file" },
   t = { "<CMD>lua require('telescope.builtin').live_grep({ hidden=true })<CR>", "Find text occurrence" },
   u = { "<CMD>silent LuaSnipUnlinkCurrent<CR>", "Unlink current snippet"},
   w = { "<CMD>w<CR>", "Save current buffer" },
   x = { "<CMD>xa<CR>", "Save and close all" },
   z = { "<CMD>Telescope file_browser<CR>", "Browse files" },
   [","] = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Find buffers" },
   ["."] = { "<CMD>lua require('telescope.builtin').resume()<CR>", "Resume last search" },
   ["/"] = { "<CMD>ToggleTerm<CR>", "Toggle last terminal" },
   ["<space>"] = { "<CMD>lua require('telescope.builtin').find_files({ hidden=true })<CR>", "Find file" },
},

   { prefix = "<leader>" }
)
