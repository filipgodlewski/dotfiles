return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
            mappings = {
               i = { ["<C-Q>"] = { require("user.quickfix").setup_search, type = "action" } },
            },
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
      { "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "Global search" },
      {
         "<leader>/",
         function() require("telescope.builtin").grep_string() end,
         desc = "Selection global search",
         mode = "v",
      },
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
