local sessions = require "sessions"
sessions.setup {
   session_filepath = vim.fn.stdpath "data" .. "/sessions",
   absolute = true,
}

local suppressed_dirs = {
   "/",
   "~",
   "~/Downloads",
   "~/.cargo",
}

local function is_suppressed(path)
   for _, dir in ipairs(suppressed_dirs) do
      if path == vim.fn.expand(dir) then return true end
   end
   return false
end

local function clean_workspace_up()
   require("neotest").summary.close()
   require("trouble").close()
   require("dap").terminate()
   require("close_buffers").delete { type = "nameless", force = true }
   require("close_buffers").delete { type = "hidden", force = true }
end

local function clear_all()
   vim.cmd "bd%"
   vim.cmd "clearjumps"
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
end

local function activate_virtual_env(path)
   local virtual_env = path .. "venv"
   local bin = virtual_env .. "/bin"
   if vim.fn.isdirectory(bin) == 0 then return end
   vim.env.VIRTUAL_ENV = virtual_env
   vim.env._OLD_VIRTUAL_PATH = vim.env.PATH
   vim.env.PATH = string.format("%s:%s", bin, vim.env.PATH)
   if vim.env.PYTHONHOME then
      vim.env._OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
      vim.env.PYTHONHOME = nil
   end
end

local function setup_env(path)
   deactivate_virtual_env()
   activate_virtual_env(path)
end

require("workspaces").setup {
   mru_sort = false,
   hooks = {
      open_pre = function(_, path)
         clean_workspace_up()
         if not is_suppressed(path) then sessions.save(nil, { silent = true }) end
         clear_all()
      end,
      open = function(_, path)
         local opts = { silent = true }
         if is_suppressed(path) then opts["autosave"] = false end
         sessions.load(nil, opts)
         setup_env(path)
      end,
   },
}

vim.api.nvim_create_autocmd({ "VimEnter" }, {
   group = vim.api.nvim_create_augroup("ChooseWorkspace", { clear = true }),
   callback = function()
      if #vim.api.nvim_get_vvar "argv" == 1 then require("telescope").extensions.workspaces.workspaces() end
   end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
   group = vim.api.nvim_create_augroup("CleanupStuff", { clear = true }),
   callback = clean_workspace_up,
})
