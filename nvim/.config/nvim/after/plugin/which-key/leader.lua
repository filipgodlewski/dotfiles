require("which-key").register({
      R = {
         name = "Run",
         p = {
            name = "Python",
            f = {":w<CR>:!python3 %<CR>", "Run current file"},
         },
      },

      S = {
         name = "Set",
         l = {":set showbreak=↪<CR>:set listchars=tab:▷▷⋮,eol:↲,nbsp:␣,trail:⋅,extends:⟩,precedes:⟨,space:⋅<CR>:set list<CR>", "List chars on"},
         L = {":set list!<CR>", "List chars off"},
      },

      T = {
         name = "Tab",
         N = {":tabnew<CR>", "Create new tab"},
         L = {":tabs<CR>", "List all tabs and windows they contain"},
         c = {":tabclose<CR>", "Close current tab"},
         f = {":tabfirst<CR>", "Go to first tab"},
         l = {":tablast<CR>", "Go to last tab"},
         n = {":tabnext<CR>", "Go to next tab"},
         o = {":tabonly<CR>", "Close all other tabs"},
         p = {":tabprevious<CR>", "Go to previous tab"},
         s = {":tab split<CR>", "Move current buffer to new tab"},
      },

      b = {
         name = "Buffer",
         b = {":Telescope buffers<CR>", "Find buffers"},
         d = {":bd<CR>", "Kill buffer & close split"},
         k = {":bp<CR>:bd#<CR>", "Kill buffer without closing the split"},
         n = {":bn<CR>", "Go to next buffer"},
         p = {":bp<CR>", "Go to previous buffer"},
      },

      f = {
         name = "File",
         F = {":Telescope find_files<CR>", "Find file excluding hidden files"},
         G = {":Telescope live_grep<CR>", "Find text occurrence excluding hidden files"},
         f = {":Telescope find_files hidden=false<CR>", "Find file"},
         g = {":Telescope live_grep hidden=false<CR>", "Find text occurrence"},
         n = {":enew<CR>", "Open new file"},
         r = {":Telescope oldfiles<CR>", "Open recent file"},
         s = {
            name = "Search",
            g = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/git/.config/git/'}}<CR>", "Git files"},
            n = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/nvim/.config/nvim/'}}<CR>", "Nvim files"},
            o = {":lua require('telescope.builtin').find_files {search_dirs = {'~/Documents/org/'}}<CR>", "Orgmode files"},
            z = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/zsh/.config/zsh/'}}<CR>", "Zsh files"},
         },
         w = {":lua Format_and_test()<CR>", "Format on save and run unit tests"},
      },

      g = {
         name = "Git",
         b = {":Telescope git_branches<CR>", "Perform actions on git branches"},
         c = {":Telescope git_commits<CR>", "Checkout on selected commit"},
         s = {":Telescope git_status<CR>", "List git status for current directory"},
         S = {":Telescope git_stash<CR>", "Apply stash"},
      },

      h = {
         name = "Hunks",
      },

      i = {
         name = "Insert",
         j = {":norm o<CR>", "Insert new line below current line"},
         k = {":norm O<CR>", "Insert new line above current line"},
         f = {
           name = "File",
           p = {
              name = "Path",
              A = {"\"=expand('%:p')<CR>P", "Absolute file path, before cursor"},
              a = {"\"=expand('%:p')<CR>p", "Absolute file path, after cursor"},
           },
         },
      },

      l = {
         name = "LSP",
         T = {":TroubleToggle lsp_workspace_diagnostics<CR>", "Toggle troubles for the current workspace"},
         a = {":Lspsaga code_action<CR>", "Show available code actions"},
         d = {":lua vim.lsp.buf.definition()<CR>", "Show definition"},
         f = {":Lspsaga lsp_finder<CR>", "Find definition and references"},
         l = {":Lspsaga show_line_diagnostics<CR>", "Show line diagnostics"},
         k = {":Lspsaga hover_doc<CR>", "Show documentation"},
         n = {":Lspsaga diagnostic_jump_next<CR>", "Go to next diagnostic"},
         p = {":Lspsaga diagnostic_jump_prev<CR>", "Go to previous diagnostic"},
         s = {":Lspsaga signature_help<CR>", "Open signature help"},
         t = {":TroubleToggle lsp_document_diagnostics<CR>", "Toggle troubles for the current window"},
      },

      o = {
         name = "OrgMode",
         a = "Agenda",
         c = "Capture",
      },

      p = {
         name = "Path",
         c = {":lcd %:h<CR>", "Current file's directory"},
         g = {":exe 'lcd' system('git rev-parse --show-toplevel')<CR>", "Base git directory"},
      },

      r = {
         name = "Refactor",
         f = {":lua vim.lsp.buf.formatting()<CR>", "Format code"},
         r = {":Lspsaga rename<CR>", "Rename with LSP"},
      },

      s = {
         name = "Search",
         H = {":Telescope highlights<CR>", "Search through highlights"},
         M = {":Telescope man_pages", "Find man page"},
         c = {":Telescope command_history<CR>", "Search through vim commands"},
         h = {":Telescope help_tags<CR>", "Find help tags"},
         v = {":Telescope vim_options<CR>", "Search & edit vim options"},
         m = {":Telescope marks<CR>", "Find vim marks"},
      },

      t = {
         name = "Terminal",
         c = {":ToggleTermCloseAll<CR>", "Close all terminals at once"},
         o = {":ToggleTermOpenAll<CR>", "Open all terminals at once"},
         r = {":lua Repl()<CR>", "Open REPL"},
         t = {":ToggleTerm<CR>", "Toggle last terminal"},
         u = {":lua UnitTests()<CR>", "Run unit tests"},
      },

      v = {
         name = "Vim",
         s = {":wa<CR>:so $MYVIMRC<CR>:noh<CR>:echo '[vim init write & reload]'<CR>", "Source vim configuration"},
      },

      w = {
         name = "Window",
         c = {":close<CR>", "Close current window, don't kill buffer"},
         h = {"<C-W>h", "Switch to the pane on the left"},
         j = {"<C-W>k", "Switch to the pane below"},
         k = {"<C-W>k", "Switch to the pane above"},
         l = {"<C-W>l", "Switch to the pane on the right"},
         s = {":sp<CR>", "Split window horizontally"},
         v = {":vs<CR>", "Split window vertically"},
      },

      ["J"] = {":m .+1<CR>==", "Move current line down"},
      ["K"] = {":m .-2<CR>==", "Move current line up"},
      ["Y"] = {"mzgg\"*yG`z", "Yank whole file to the system-wide register"},
      ["d"] = {"\"_d", "Delete motion without yanking"},
      ["."] = {":Telescope find_files hidden=false<CR>", "Find file"},
      [","] = {":Telescope buffers<CR>", "Find buffers"},
      ["/"] = {":ToggleTerm<CR>", "Toggle last terminal"},
      ["<space>"] = {":Telescope find_files hidden=false<CR>", "Find file"},
   },

   {prefix = "<leader>"}
)
