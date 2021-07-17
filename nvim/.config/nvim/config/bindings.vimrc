lua << EOF
local wk = require("which-key")

wk.register({
      R = {
         name = "Refactor",
	       o = {":copen<CR>:set modifiable<CR>", "Open quickfix list"},
      },
      S = {
         name = "Set",
         l = {":set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣<CR>:set list<CR>", "List chars on"},
         L = {":set list!<CR>", "List chars off"},
      },
      b = {
         name = "Buffer",
         d = {":bd<CR>", "Kill buffer & close split"},
         k = {":bp|bd#<CR>", "Kill buffer without closing the split"},
         n = {":bn<CR>", "Go to next buffer"},
         p = {":bp<CR>", "Go to previous buffer"},
      },
      l = {
         name = "Linting",
         c = {":lclose<CR>", "Close the location list for the current window"},
         f = {":ALEFix<CR>", "Fix linting errors"},
         n = {":ALENextWrap<CR>", "Go to next linting occurrence"},
         o = {":lopen<CR>", "Open location list for the current window"},
         p = {":ALEPreviousWrap<CR>", "Go to previous linting occurrence"},
      },
      f = {
         name = "File",
         f = {":Telescope find_files<CR>", "Find file"},
         n = {":enew<CR>", "Open new file"},
         g = {":Telescope live_grep<CR>", "Find text occurrence"},
         r = {":Telescope oldfiles<CR>", "Open recent file"},
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
      r = {
      	 name = "Run",
      	 p = {
      	    name = "Python",
            f = {":w<CR>:!python3 %<CR>", "Run current file"},
         },
      },
      s = {
      	 name = "Search",
         H = {":Telescope highlights<CR>", "Search through highlights"},
         M = {":Telescope man_pages", "Find man page"},
         b = {":Telescope buffers<CR>", "Find buffers"},
         c = {":Telescope command_history<CR>", "Search through vim commands"},
         h = {":Telescope help_tags<CR>", "Find help tags"},
         v = {":Telescope vim_options<CR>", "Search & edit vim options"},
         m = {":Telescope marks<CR>", "Find vim marks"},
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
      ["<space>"] = {":Telescope find_files<CR>", "Find file"},
      ["."] = {":Telescope find_files<CR>", "Find file"},
   },
   {prefix = "<leader>"}
)

wk.register({
      g = {
         name = "Global",
         y = {"\"*y", "Yank motion to system-wide register"},
         Y = {"\"*Y", "Yank to EOL to system-wide register"},
      },
      ["<C-]>"] = {"<C-]>zz", "Go to tag"},
      ["<ESC>"] = {":noh<CR>", "Escape"},
      ["Y"] = {"\"*yy", "Yank entire line to system-wide register"},
      ["S"] = {"i<CR><esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w", "Split line"},
   }
)

wk.register({
      g = {
         name = "Global",
         y = {"\"*y", "Yank motion to system-wide register"},
      },
      ["<"] = {"<gv", "Indent left"},
      [">"] = {">gv", "Indent right"},
   },
   {mode = "v"}
)
EOF
