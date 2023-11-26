-- I stole a part of it from https://github.com/windwp/nvim-projectconfig
-- I just didn't need the whole plugin for it.

local config = {
   project_dir = vim.fn.stdpath "data" .. "/project-configs/",
   configs_repo = false,
}

local project_dir = vim.fn.stdpath "data" .. "/project-configs/"

local ensure_private_configs = function()
   -- TODO: If repo not set, return
   if vim.fn.empty(vim.fn.glob(project_dir)) == 1 then
      vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/filipgodlewski/project-configs", project_dir }
   end
end

local M = {}

local backed_up_configs = {}

local get_project_basename = function()
   local git_dir = vim.cmd "silent !git rev-parse --show-toplevel"
   local dir = git_dir ~= "" and git_dir or vim.fn.getcwd()
   return vim.fs.basename(dir)
end

local get_local_config = function()
   local basename = string.gsub(get_project_basename(), "%.", "-")
   -- TODO: opts for string substitution, both in and out
   return project_dir .. basename .. "-cfg.lua"
   -- TODO: Options for suffix
end

local load_local_config = function()
   local file_found = loadfile(get_local_config())
   if file_found then return file_found() end
end

local backup_original_opts = function(plugin)
   if not backed_up_configs[plugin] then
      backed_up_configs[plugin] = require("lazy.core.config").plugins[plugin].opts or {}
   end
end

local get_plugin_index = function(plugin)
   local expr = string.format("v:val == '%s'", plugin)
   return vim.fn.indexof(vim.tbl_keys(require("lazy").plugins()), expr)
end

local create_new_opts = function(plugin, overrides)
   return vim.tbl_deep_extend("force", backed_up_configs[plugin], overrides[plugin] or {})
end

local clean_state_up = function() end

M.config = {}

M.load = function()
   -- FIXME: should first make lazy pristine -> get all keys from backed_up_configs and load originals
   -- TODO: Search by either custom on plugin name
   -- get local project configs
   local overrides = load_local_config() or {}
   local plugins = vim.tbl_keys(overrides)

   for _, plugin in ipairs(plugins) do
      backup_original_opts(plugin)
      local index_ = get_plugin_index(plugin)
      local new_opts = create_new_opts(plugin, overrides)

      require("lazy").plugins()[index_] = new_opts

      -- if plugin was already loaded, reload
      if require("user.helpers").did_load_lazy_plugin(plugin) then require("lazy.core.loader").reload(plugin) end
   end
end

M.edit = function()
   local config_path = get_local_config()
   vim.cmd.edit(config_path)
end

-- TODO: Create custom command for config edit
-- TODO: Create custom command for reload

M.setup = function(opts)
   M.config = vim.tbl_extend("force", config, opts or {})
   -- TODO: Put into opts and make optional
   ensure_private_configs()
   -- TODO: Rather create a command
   vim.keymap.set("n", "<leader>!", M.edit, { desc = "Open local config file" })
end

setmetatable(M, {
   __index = {},
})

return M
