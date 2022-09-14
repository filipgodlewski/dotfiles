require("which-key").register({
   D = {
      name = "Directory",
      g = {
         name = "Global",
         c = { "<CMD>cd %:h<CR>", "Current file's directory" },
         g = { "<CMD>exe 'cd' system('git rev-parse --show-toplevel')<CR>", "Base git directory" },
         p = { "<CMD>cd -<CR>", "Previous directory" },
      },
      l = {
         name = "Local",
         c = { "<CMD>lcd %:h<CR>", "Current file's directory" },
         g = { "<CMD>exe 'lcd' system('git rev-parse --show-toplevel')<CR>", "Base git directory" },
         p = { "<CMD>lcd -<CR>", "Previous directory" },
      },
      p = { "<CMD>pwd<CR>", "Print current working directory" },
   },

   J = { "<CMD>m .+1<CR>==", "Move current line down" },

   K = { "<CMD>m .-2<CR>==", "Move current line up" },

   S = {
      name = "Settings",
      S = {
         name = "Set",
         l = { "<CMD>set showbreak=↪<CR>:set listchars=tab:▷▷⋮,eol:↲,nbsp:␣,trail:⋅,extends:⟩,precedes:⟨,space:⋅<CR>:set list<CR>", "List chars on" },
         L = { "<CMD>set list!<CR>", "List chars off" },
      },
      s = {
         name = "Source",
         s = { "<CMD>source ~/.config/nvim/after/plugin/luasnip.lua<CR>", "Luasnip" }
      }
   },

   Y = { "mzgg\"*yG`z", "Yank whole file to the system-wide register" },

   d = { "\"_d", "Delete motion without yanking" },

   b = {
      name = "Buffer",
      b = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Find buffers" },
      d = {
         name = "Delete",
         ["."] = { "<CMD>lua require('close_buffers').delete({ type='hidden', force = true })<CR>", "Delete all hidden buffers" },
         a = { "<CMD>lua require('close_buffers').delete({ type='all', force = true })<CR>", "Delete all buffers" },
         d = { "<CMD>lua require('close_buffers').delete({ type='this' })<CR>", "Delete this buffer" },
         n = { "<CMD>lua require('close_buffers').delete({ type='nameless', force = true })<CR>", "Delete all nameless buffers" },
         o = { "<CMD>lua require('close_buffers').delete({ type='other', force = true })<CR>", "Delete all other buffers" },
      },
      n = { "<CMD>bn<CR>", "Go to next buffer" },
      p = { "<CMD>bp<CR>", "Go to previous buffer" },
   },

   s = {
      name = "Search",
      f = {
         name = "File",
         ["."] = { "<CMD>lua require('telescope.builtin').find_files({ hidden=true })<CR>", "Find file (+hidden)" },
         f = { "<CMD>lua require('telescope.builtin').find_files()<CMD>", "Find file" },
         r = { "<CMD>lua require('telescope.builtin').oldfiles()<CR>", "Find recent file" },
      },
      s = {
         name = "System",
         m = { "<CMD>lua require('telescope.builtin').man_pages", "Find man page" },
      },
      t = {
         name = "Text",
         ["."] = { "<CMD>lua require('telescope.builtin').live_grep({ hidden=true })<CR>", "Find text occurrence (+hidden)" },
         T = { "<CMD>TodoTelescope<CR>", "Find all Todos" },
         t = { "<CMD>lua require('telescope.builtin').live_grep()<CR>", "Find text occurrence" },
         b = { "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Fuzzy search within the current buffer" },
      },
      v = {
         name = "Vim",
         c = { "<CMD>lua require('telescope.builtin').command_history()<CR>", "Search through vim commands" },
         h = { "<CMD>lua require('telescope.builtin').highlights()<CR>", "Search through highlights" },
         m = { "<CMD>lua require('telescope.builtin').marks()<CR>", "Find vim marks" },
         o = { "<CMD>lua require('telescope.builtin').vim_options()<CR>", "Search & edit vim options" },
         t = { "<CMD>lua require('telescope.builtin').help_tags()<CR>", "Find help tags" },
      },
   },

   g = {
      name = "Git",
      B = { "<CMD>lua require('telescope.builtin').git_branches()<CR>", "Perform actions on git branches" },
      C = { "<CMD>lua require('telescope.builtin').git_commits()<CR>", "Checkout on selected commit" },
      S = { "<CMD>lua require('telescope.builtin').git_stash()<CR>", "Search through stashes with an option to apply them" },
      c = {
         name = "Conflict",
         c = {
            name = "Choose",
            o = { "<CMD>GitConflictChooseOurs<CR>", "Choose ours (local)" },
            t = { "<CMD>GitConflictChooseTheirs<CR>", "Choose theirs (remote)" },
            b = { "<CMD>GitConflictChooseBoth<CR>", "Choose both" },
            n = { "<CMD>GitConflictChooseNone<CR>", "Choose none" },
         },
         l = { "<CMD>GitConflictListQf<CR>", "List all conflicts" },
         n = { "<CMD>GitConflictNextConflict<CR>", "Go to next conflict" },
         p = { "<CMD>GitConflictPrevConflict<CR>", "Go to previous conflict" },
      },
      d = {
         name = "Diff",
         O = { "<CMD>DiffviewOpen ", "Open diff view (insert ready)" },
         o = { "<CMD>DiffviewOpen<CR>", "Open diff view" },
         c = { "<CMD>DiffviewClose<CR>", "Close diff view" },
         r = { "<CMD>DiffviewRefresh<CR>", "Refresh diff view" },
         h = { "<CMD>DiffviewFilesHistory<CR>", "Open file history diff view" },
         t = { "<CMD>DiffviewToggleFiles<CR>", "Toggle Files pane" },
         f = { "<CMD>DiffviewFocusFiles<CR>", "Focus on Files pane" },
      },
      h = {
         name = "Hunks",
         R = { "<CMD>lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
         b = { "<CMD>lua require('gitsigns').blame_line(full=true)<CR>", "Show blame for current line" },
         d = { "<CMD>lua require('gitsigns').toggle_deleted()<CR>", "Show deleted lines" },
         p = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
         r = { "<CMD>lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
         s = { "<CMD>lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
         u = { "<CMD>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo staging hunk" },
      },
      s = { "<CMD>lua require('telescope.builtin').git_status()<CR>", "List git status for current directory" },
   },

   i = {
      name = "Insert",
      j = { "<CMD>norm o<CR>", "Insert new line below current line" },
      k = { "<CMD>norm O<CR>", "Insert new line above current line" },
      p = {
         name = "Path",
         A = { "\"=expand('%:p')<CR>P", "Absolute file path, before cursor" },
         a = { "\"=expand('%:p')<CR>p", "Absolute file path, after cursor" },
      },
   },

   l = {
      name = "LSP",
      R = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Find references" },
      T = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Toggle troubles for the current workspace" },
      d = { "<CMD>lua require('telescope.builtin').lsp_definitions({ jump_type='never' })<CR>", "Show definition" },
      k = { "<CMD>lua vim.lsp.buf.hover()<CR>", "Show documentation" },
      n = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      p = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
      r = {
         name = "Refactor",
         a = { "<CMD>CodeActionMenu<CR>", "Show available code actions" },
         f = { "<CMD>lua vim.lsp.buf.formatting_sync()<CR><CMD>w<CR>", "Format code" },
         r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename with LSP" },
      },
      s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Open signature help" },
      t = { "<CMD>TroubleToggle document_diagnostics<CR>", "Toggle troubles for the current window" },
   },

   m = {
      name = "Manipulate",
      s = { "<CMD>ISwapWith<CR>", "Swap Current element with" },
      S = { "<CMD>ISwap<CR>", "Select elements and swap them" },
   },

   p = { "\"_dP", "Safe paste last copy" },

   t = {
      name = "Terminal",
      c = { "<CMD>ToggleTermCloseAll<CR>", "Close all terminals at once" },
      o = { "<CMD>ToggleTermOpenAll<CR>", "Open all terminals at once" },
      r = { "<CMD>!python3 %<CR>", "Run python current file" },
      R = {
         name = "REPL",
         r = { "<CMD>lua Repl()<CR>", "Open REPL" },
         R = { "<CMD>lua Repl(nil, {'-i', vim.api.nvim_buf_get_name(0)})<CR>", "Open REPL with current file being loaded" },
      },
      t = { "<CMD>ToggleTerm<CR>", "Toggle last terminal" },
      u = { "<CMD>lua UnitTests()<CR>", "Run unit tests" },
   },

   u = {
      name = "Unit Tests",
   },

   w = {
      name = "Window",
      c = { "<CMD>close<CR>", "Close current window, don't kill buffer" },
      h = { "<C-W>h", "Switch to the pane on the left" },
      j = { "<C-W>k", "Switch to the pane below" },
      k = { "<C-W>k", "Switch to the pane above" },
      l = { "<C-W>l", "Switch to the pane on the right" },
      s = { "<CMD>sp<CR>", "Split window horizontally" },
      v = { "<CMD>vs<CR>", "Split window vertically" },
   },

   ["."] = { "<CMD>lua require('telescope.builtin').find_files({ hidden=true })<CR>", "Find file (+hidden)" },
   [","] = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "Find buffers" },
   ["/"] = { "<CMD>ToggleTerm<CR>", "Toggle last terminal" },
   ["<space>"] = { "<CMD>lua require('telescope.builtin').find_files({ hidden=false })<CR>", "Find file" },
},

   { prefix = "<leader>" }
)
