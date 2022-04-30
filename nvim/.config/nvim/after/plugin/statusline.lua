local M = {}

M.colors = {active = "%#StatusLine#", inactive = "%#StatusLineNC#"}
M.get_git_status = function()
  local git_dir = vim.fn.system("git branch --show-current")
  local is_git_dir = vim.fn.matchstr(git_dir, "^fatal:.*") == ""
  return is_git_dir and string.format("  %s ", vim.trim(git_dir)) or "  -- "
end

M.set_active = function(self)
  local git = self:get_git_status()
  local filename = " %<%f "
  local line_col = " %l:%c "

  return table.concat({self.colors.active, git, "%=", filename, "%=", line_col})
end

M.set_inactive = function(self)
  return self.colors.inactive .. "%= %F %="
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
