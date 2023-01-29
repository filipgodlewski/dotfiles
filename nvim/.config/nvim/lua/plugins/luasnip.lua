return {
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
   lazy = true,
}
