local M = {}

M.colors = {active = '%#StatusLine#', inactive = '%#StatusLineNC#'}
M.get_git_status = function(self)
  local signs = vim.b.gitsigns_status_dict or {head = ''}
  local is_head_empty = signs.head ~= ''
  return is_head_empty and string.format('  %s ', signs.head) or '  -- '
end

M.set_active = function(self)
  local colors = self.colors
  local git = self:get_git_status()
  local filename = " %<%f "
  local line_col = " %l:%c "

  return table.concat({colors.active, git, "%=", filename, "%=", line_col})
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
  end
})

vim.cmd([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  augroup END
]])
