local font_sizes = {
   macbook_pro_16 = 14,
   mac_mini = 16,
   big = 24,
   gigantic = 32,
}

vim.api.nvim_create_user_command("Font", function()
   local function format_item(item)
      local words = vim.split(item, "_")
      local capitalized_words = {}
      for _, word in ipairs(words) do
         local _word = string.gsub(word, "^%l", string.upper)
         table.insert(capitalized_words, _word)
      end
      return string.format("%s (%s)", table.concat(capitalized_words, " "), font_sizes[item])
   end

   local function on_choice(choice)
      if not choice then return end
      local cmd = "alacritty msg config -w %s font.size=%s"
      local win_id = vim.fn.expand "$ALACRITTY_WINDOW_ID"
      vim.fn.system(cmd:format(win_id, font_sizes[choice]))
      vim.cmd "redraw"
   end

   local opts = { prompt = "Select Alacritty Font Size", format_item = format_item }

   vim.ui.select(vim.tbl_keys(font_sizes), opts, on_choice)
end, {})

vim.api.nvim_create_user_command("FontReset", function()
   local cmd = "alacritty msg config -w %s --reset"
   local win_id = vim.fn.expand "$ALACRITTY_WINDOW_ID"
   vim.fn.system(cmd:format(win_id))
   vim.cmd "redraw"
end, {})
