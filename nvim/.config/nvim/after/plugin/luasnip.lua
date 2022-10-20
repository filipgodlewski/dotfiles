local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.setup({
   history = true,
   update_events = "TextChanged,TextChangedI",
   delete_check_events = "TextChanged,InsertLeave",
   enable_autosnippets = false,
   ext_opts = {
      [types.choiceNode] = {
         active = {
            virt_text = { { "CHOOSE:", "LuaSnipChoiceAvailable" } },
         },
      },
   },
})

require "luasnip-ts-snippets".setup {
   active_choice_highlight_group = "LuaSnipChoiceActive",
}
