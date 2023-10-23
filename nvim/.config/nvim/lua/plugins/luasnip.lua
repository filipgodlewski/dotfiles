return {
   {
      "L3MON4D3/LuaSnip",
      dependencies = {
         {
            "filipgodlewski/luasnip-ts-snippets.nvim",
            opts = { active_choice_highlight_group = "LuaSnipChoiceActive" },
         },
      },
      opts = function()
         return {
            history = true,
            update_events = "TextChanged,TextChangedI",
            delete_check_events = "TextChanged,InsertLeave",
            enable_autosnippets = false,
            ext_opts = {
               [require("luasnip.util.types").choiceNode] = {
                  active = {
                     virt_text = { { "CHOOSE:", "LuaSnipChoiceAvailable" } },
                  },
               },
            },
         }
      end,
   },
   {
      "benfowler/telescope-luasnip.nvim",
      dependencies = {
         "L3MON4D3/LuaSnip",
         "nvim-telescope/telescope.nvim",
      },
      keys = {
         {
            "<C-L>",
            function()
               require("telescope").load_extension "luasnip"
               require("telescope").extensions.luasnip.luasnip(
                  require("telescope.themes").get_dropdown { previewer = false, layout_config = { width = 0.5 } }
               )
            end,
            desc = "Open snippet picker",
            mode = "i",
         },
      },
   },
}
