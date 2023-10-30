local user_qf = require "user.helpers.quickfix"

return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
   },
   opts = function()
      return {
         defaults = {
            prompt_prefix = "   ",
            selection_caret = "    ",
            multi_icon = " ",
            entry_prefix = "     ",
            vimgrep_arguments = {
               "rg",
               "--color=never",
               "--no-heading",
               "--with-filename",
               "--line-number",
               "--column",
               "--smart-case",
               "--trim",
            },
            file_ignore_patterns = {
               "dist",
               "target",
               "node_modules",
               "pack/plugins",
            },
            mappings = { i = { ["<C-q>"] = { user_qf.setup_search, type = "action" } } },
         },
         extensions = {
            fzf = {
               override_generic_sorter = true,
               override_file_sorter = true,
               case_mode = "smart_case",
            },
         },
         pickers = {
            buffers = {
               theme = "dropdown",
               mappings = {
                  i = { ["<C-d>"] = "delete_buffer" },
                  n = { ["<C-d>"] = "delete_buffer" },
               },
            },
            find_files = {
               file_ignore_patterns = {
                  ".git/",
                  "venv/",
                  "**/__*",
                  "target/",
               },
            },
            spell_suggest = { theme = "cursor" },
         },
      }
   end,
   config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension "fzf"
      telescope.load_extension "ui-select"
      vim.keymap.set(
         "n",
         "<leader>'",
         require("telescope.builtin").resume,
         { silent = true, desc = "Open last used picker" }
      )
   end,
   keys = {
      {
         "<leader><space>",
         function() require("telescope.builtin").find_files { hidden = true } end,
         desc = "Open file picker",
      },
      { "<leader>/", function() user_qf.search "live_grep" end, desc = "Search globally" },
      { "<leader>/", function() user_qf.search "grep_string" end, desc = "Search globally", mode = "v" },
      { "<leader>?", function() require("telescope.builtin").help_tags() end, desc = "Open Neovim help picker" },
      { "<leader>b", function() require("telescope.builtin").buffers() end, desc = "Open buffer picker" },
      {
         "<leader>W",
         function()
            require("telescope").load_extension "workspaces"
            require("telescope").extensions.workspaces.workspaces()
         end,
         desc = "Open workspace picker",
      },
   },
}
