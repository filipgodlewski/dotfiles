return {
   "nvim-tree/nvim-tree.lua",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   opts = function()
      return {
         sync_root_with_cwd = true,
         diagnostics = { enable = true },
         select_prompts = true,
         view = {
            width = 40,
            mappings = {
               list = {
                  {
                     key = "w",
                     action = "collapse_all_but_open",
                     action_cb = function() require("nvim-tree.api").tree.collapse_all(true) end,
                  },
               },
            },
         },
         renderer = { full_name = true, highlight_git = true },
         trash = { cmd = "rip" },
      }
   end,
   config = true,
   keys = {
      {
         "<leader>nc",
         function() require("nvim-tree.api").tree.toggle { find_file = true, focus = true } end,
         desc = "Current",
      },
      { "<leader>nt", function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle" },
      { "<leader>nf", function() require("nvim-tree.api").tree.focus() end, desc = "Focus" },
   },
}
