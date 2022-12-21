local choices = {
   "messages",
   "Notifications",
}

vim.api.nvim_create_user_command("Scratch", function()
   local format_item = function(item) return string.gsub(item, "^%l", string.upper) end
   local opts = { prompt = "Create Information Scratch Buffer", format_item = format_item }

   local on_choice = function(choice)
      local bufname = "[User Scratch]"
      local bufnr = vim.fn.bufnr("\\" .. bufname)
      if bufnr > 0 then vim.cmd(string.format("bw! %s", bufnr)) end

      bufnr = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_name(bufnr, bufname)

      vim.cmd "below new"
      vim.cmd "wincmd J"
      vim.api.nvim_win_set_height(0, 10)
      vim.api.nvim_win_set_buf(0, bufnr)
      vim.cmd(string.format([[put =execute('%s')]], choice))
      vim.keymap.set("n", "q", "<cmd>bw!<cr>", { buffer = true, desc = "Close User Scratch" })
   end

   vim.ui.select(choices, opts, on_choice)
end, {})
