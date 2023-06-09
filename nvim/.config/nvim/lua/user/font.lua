local font_sizes = {
   macbook_pro_16 = 14,
   mac_mini = 16,
   big = 24,
   gigantic = 32,
}

local get_alacritty_win_id = function() return vim.fn.expand "$ALACRITTY_WINDOW_ID" end

local set_alacritty = function(size)
   local cmd = "alacritty msg config -w %s font.size=%s"
   vim.fn.system(cmd:format(get_alacritty_win_id(), size))
   vim.cmd "redraw"
end

local format_item = function(item)
   local words = vim.split(item, "_")
   local capitalized_words = {}
   for _, word in ipairs(words) do
      local _word = string.gsub(word, "^%l", string.upper)
      table.insert(capitalized_words, _word)
   end
   return string.format("%s (%s)", table.concat(capitalized_words, " "), font_sizes[item])
end

local on_choice = function(choice)
   if not choice then return end
   set_alacritty(font_sizes[choice])
end

vim.api.nvim_create_user_command("Font", function(params)
   assert(#params.fargs < 2, "Too many arguments! Only 1 allowed")

   if params.args ~= "" then
      local size = tonumber(params.fargs[1])
      assert(size ~= nil, "Optional argument has to be a number.")
      set_alacritty(size)
      return
   end

   local opts = { prompt = "Select Alacritty Font Size", format_item = format_item }
   vim.ui.select(vim.tbl_keys(font_sizes), opts, on_choice)
end, { nargs = "*" })

vim.api.nvim_create_user_command("FontReset", function()
   local cmd = "alacritty msg config -w %s --reset"
   vim.fn.system(cmd:format(get_alacritty_win_id()))
   vim.cmd "redraw"
end, {})
