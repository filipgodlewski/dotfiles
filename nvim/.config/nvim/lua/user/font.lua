local Path = require "plenary.path"

local font_sizes = {}

local get_alacritty_win_id = function() return vim.fn.expand "$ALACRITTY_WINDOW_ID" end

local get_term_font_sizes = function()
   local f = vim.fn.expand "$ZDOTDIR/term_font_sizes"

   if vim.fn.filereadable(f) == 1 then
      local fonts_file = Path:new(f)
      local lines = fonts_file:readlines()
      for _, line in ipairs(lines) do
         if line == "" then goto continue end
         local name, value = string.match(line, "^(.+) %((%d+) pts%)")
         font_sizes[name] = value
         ::continue::
      end
   end
end

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

   font_sizes = {}
   get_term_font_sizes()
   local opts = { prompt = "Select Alacritty Font Size", format_item = format_item }
   vim.ui.select(vim.tbl_keys(font_sizes), opts, on_choice)
end, { nargs = "*" })

vim.api.nvim_create_user_command("FontReset", function()
   local cmd = "alacritty msg config -w %s --reset"
   vim.fn.system(cmd:format(get_alacritty_win_id()))
   vim.cmd "redraw"
end, {})
