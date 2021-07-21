require("telescope").setup {
   pickers = {
      live_grep = {
         hidden = true,
      },
      find_files = {
         hidden = true,
      },
      buffers = {
         theme = "dropdown",
         previewer = false,
         mappings = {
            i = {
               ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {
               ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
         },
      },
      
   },
}
