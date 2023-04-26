local function set_1char(key, dir, offset)
   return {
      key,
      function()
         require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection[dir],
            current_line_only = true,
            hint_offset = offset,
         }
      end,
      mode = { "n", "x", "o" },
      remap = true,
   }
end

return {
   {
      "phaazon/hop.nvim",
      config = true,
      keys = {
         set_1char("f", "AFTER_CURSOR", 0),
         set_1char("F", "BEFORE_CURSOR", 0),
         set_1char("t", "AFTER_CURSOR", -1),
         set_1char("T", "BEFORE_CURSOR", 1),
         { "<leader>H", function() require("hop").hint_words { multi_windows = true } end, desc = "Hop" },
      },
   },
}
