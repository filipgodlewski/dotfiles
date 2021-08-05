local wk = require("which-key")

wk.setup {
   operators = {
      ["<leader>ij"] = "Insert new line below current line",
      ["<leader>ik"] = "Insert new line above current line",
      ["<leader>d"] = "Delete motion without yanking",
   },
   key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
   }
}

wk.register({
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
         f = {":Telescope find_files<CR>", "Find file"},
         n = {":enew<CR>", "Open new file"},
         g = {":Telescope live_grep<CR>", "Find text occurrence"},
         r = {":Telescope oldfiles<CR>", "Open recent file"},
         s = {
            name = "Search",
            g = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/git/.config/git/'}}<CR>", "Git files"},
            n = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/nvim/.config/nvim/'}}<CR>", "Nvim files"},
            o = {":lua require('telescope.builtin').find_files {search_dirs = {'~/Documents/org/'}}<CR>", "Orgmode files"},
            z = {":lua require('telescope.builtin').find_files {search_dirs = {'~/dotfiles/zsh/.config/zsh/'}}<CR>", "Zsh files"},
         },
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
         f = {":ALEFix<CR>", "Format code"},
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
         name = "Tab",
         N = {":tabnew<CR>", "Create new tab"},
         L = {":tabs<CR>", "List all tabs and windows they contain"},
         c = {":tabclose<CR>", "Close current tab"},
         f = {":tabfirst<CR>", "Go to first tab"},
         l = {":tablast<CR>", "Go to last tab"},
         n = {":tabnext<CR>", "Go to next tab"},
         o = {":tabonly<CR>", "Cloose all other tabs"},
         p = {":tabprevious<CR>", "Go to previous tab"},
         s = {":tab split<CR>", "Move current buffer to new tab"},
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
      ["."] = {":Telescope find_files<CR>", "Find file"},
      [","] = {":Telescope buffers<CR>", "Find buffers"},
      ["<space>"] = {":Telescope find_files<CR>", "Find file"},
   },

   {prefix = "<leader>"}
)

wk.register({
      g = {
         name = "Global",
         y = {"\"*y", "Yank motion to system-wide register"},
         Y = {"\"*Y", "Yank to EOL to system-wide register"},
      },
      ["<C-]>"] = {":lua vim.lsp.buf.definition()<CR>zz", "Go to tag"},
      ["<ESC>"] = {":noh<CR>", "Escape"},
      ["J"] = {"mzJ`z", "Join lines, cursor stays where it was"},
      ["N"] = {"Nzzzv", "Move to previous item, make view centered"},
      ["Y"] = {"\"*y$", "Yank until the end of line to system-wide register"},
      ["S"] = {"i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w", "Split line"},
      ["n"] = {"nzzzv", "Move to next item, make view centered"},
   }
)

wk.register({
      g = {
         name = "Global",
         y = {"\"*y", "Yank motion to system-wide register"},
      },
      ["<"] = {"<gv", "Indent left"},
      [">"] = {">gv", "Indent right"},
      ["J"] = {":m '>+1<CR>gv=gv", "Move highlighted lines down"},
      ["K"] = {":m '<-2<CR>gv=gv", "Move highlighted lines up"},
   },
   {mode = "v"}
)

local opt = {expr = true, silent = true, noremap = true}
vim.api.nvim_set_keymap("i", "<C-space>", "compe#complete()", opt)
vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm(luaeval("require('nvim-autopairs').autopairs_cr()"))]], opt)
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", opt)
vim.api.nvim_set_keymap("i", ",", ",<C-g>u", {noremap = true})
vim.api.nvim_set_keymap("i", ".", ".<C-g>u", {noremap = true})
vim.api.nvim_set_keymap("i", "!", "!<C-g>u", {noremap = true})
vim.api.nvim_set_keymap("i", "?", "?<C-g>u", {noremap = true})
vim.api.nvim_set_keymap("i", "#", "X#", {noremap = true})
vim.api.nvim_set_keymap("i", "<C-h>", "<BS>", {noremap = false})
-- vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({'delta': +4})", opt)
-- vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({'delta': -4})", opt)
