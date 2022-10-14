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

require "luasnip.loaders.from_lua".load { paths = "./after/plugin/luasnip/luasnippets" }
