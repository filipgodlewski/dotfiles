-- I stole a part of it from https://github.com/windwp/nvim-projectconfig
-- I just didn't need the whole plugin for it.

local project_dir = vim.fn.expand "~/.local/share/nvim/project-configs/"

local ensure_private_configs = function()
   if vim.fn.empty(vim.fn.glob(project_dir)) == 1 then
      vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/filipgodlewski/project-configs", project_dir }
   end
end

local M = {}

M.setup = function()
   ensure_private_configs()
   vim.api.nvim_create_autocmd("VimEnter", {
      callback = require("my.project_configs").load,
      group = vim.api.nvim_create_augroup("ProjectConfig", { clear = true }),
   })
end

M._get = function()
   local git_dir = vim.cmd "silent !git rev-parse --show-toplevel"
   local dir = git_dir ~= "" and git_dir or vim.loop.cwd()
   return project_dir .. vim.fs.basename(dir) .. ".lua"
end

M.load = function()
   local config_path = M._get()
   if vim.fn.filereadable(config_path) == 1 then
      vim.cmd("silent source " .. config_path)
      vim.defer_fn(function() vim.notify(string.format(" Project config loaded from '%s'", config_path)) end, 100)
   end
end

M.open = function()
   local config_path = M._get()
   vim.cmd.edit(config_path)
end

return M
