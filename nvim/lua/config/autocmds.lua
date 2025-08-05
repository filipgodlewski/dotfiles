vim.api.nvim_create_autocmd("TermEnter", {
  group = vim.api.nvim_create_augroup("custom_term", { clear = true }),
  callback = function(ev)
    vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = ev.buf, nowait = true })
  end,
})
