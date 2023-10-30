local function is_suppressed(path)
   local suppressed_dirs = {
      "/",
      "~",
      "~/Downloads",
      "~/.cargo",
   }
   for _, dir in ipairs(suppressed_dirs) do
      if path == vim.fn.expand(dir) then return true end
   end
   return false
end

local did_load_lazy_plugin = function(name)
   local loaded_plugins = vim.tbl_flatten(vim.tbl_map(function(v)
      if v._.loaded then return v.name end
   end, require("lazy").plugins()))
   return vim.tbl_contains(loaded_plugins, name)
end

local kill_lsp = function()
   local active_clients = vim.lsp.get_active_clients()
   if active_clients then
      for _, client in ipairs(active_clients) do
         vim.cmd(string.format("LspStop %s", client.id))
      end
   end
end

local function clean_workspace_up()
   if did_load_lazy_plugin "neotest" then require("neotest").summary.close() end
   if did_load_lazy_plugin "trouble.nvim" then require("trouble").close() end
   if did_load_lazy_plugin "nvim-dap" then require("dap").terminate() end
   local buf = require "close_buffers"
   buf.delete { type = "nameless", force = true }
   buf.delete { type = "hidden", force = true }
   buf.delete { regex = "^term://.*", force = true }
end

local function deactivate_virtual_env()
   if vim.env._OLD_VIRTUAL_PATH then
      vim.env.PATH = vim.env._OLD_VIRTUAL_PATH
      vim.env._OLD_VIRTUAL_PATH = nil
   end
   if vim.env._OLD_VIRTUAL_PYTHONHOME then
      vim.env.PYTHONHOME = vim.env._OLD_VIRTUAL_PYTHONHOME
      vim.env._OLD_VIRTUAL_PYTHONHOME = nil
   end
   vim.env.VIRTUAL_ENV = nil
end

local function get_virtual_env_path(path)
   if path[#path] ~= "/" then path = path .. "/" end
   return path .. "venv"
end

local function activate_virtual_env(path)
   deactivate_virtual_env()

   local virtual_env = get_virtual_env_path(path)
   if vim.fn.isdirectory(virtual_env) == 0 then return end
   vim.env.VIRTUAL_ENV = virtual_env

   vim.env._OLD_VIRTUAL_PATH = vim.env.PATH
   vim.env.PATH = virtual_env .. "/bin:" .. vim.env.PATH

   if vim.env.PYTHONHOME then
      vim.env._OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
      vim.env.PYTHONHOME = nil
   end
end

vim.api.nvim_create_autocmd("VimEnter", {
   group = vim.api.nvim_create_augroup("ChooseWorkspace", { clear = true }),
   callback = function()
      local home = vim.fn.expand "~"
      local args = vim.api.nvim_get_vvar "argv"
      local cwd = vim.fn.getcwd()
      if #args == 2 and cwd == home and vim.tbl_contains(args, "--embed") then
         require("telescope").extensions.workspaces.workspaces()
         return
      end
      activate_virtual_env(cwd)
   end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
   group = vim.api.nvim_create_augroup("CleanupStuff", { clear = true }),
   callback = clean_workspace_up,
})

return {
   {
      "natecraddock/sessions.nvim",
      opts = {
         events = { "VimLeavePre" },
         session_filepath = vim.fn.stdpath "data" .. "/sessions",
         absolute = true,
      },
      cmd = { "SessionsLoad", "SessionsSave", "SessionsStop" },
   },
   {
      "natecraddock/workspaces.nvim",
      dependencies = { "natecraddock/sessions.nvim" },
      opts = function()
         return {
            mru_sort = false,
            hooks = {
               open_pre = function(_, path)
                  clean_workspace_up()
                  if not is_suppressed(path) then require("sessions").save(nil, { silent = true }) end
                  vim.cmd "bd%"
                  vim.cmd "clearjumps"
                  kill_lsp()
               end,
               open = function(_, path)
                  local opts = { silent = true, autosave = true }
                  if is_suppressed(path) then opts["autosave"] = false end
                  require("sessions").load(nil, opts)
                  activate_virtual_env(path)
               end,
            },
         }
      end,
      cmd = {
         "WorkspacesAdd",
         "WorkspacesAddDir",
         "WorkspacesRemove",
         "WorkspacesRemoveDir",
         "WorkspacesRename",
         "WorkspacesOpen",
         "WorkspacesList",
         "WorkspacesListDirs",
         "WorkspacesSyncDirs",
      },
   },
}
