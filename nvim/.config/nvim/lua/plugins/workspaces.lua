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

local function clean_workspace_up()
   local loaded_plugins = vim.tbl_flatten(vim.tbl_map(function(v)
      if v._.loaded then return v.name end
   end, require("lazy").plugins()))
   if vim.tbl_contains(loaded_plugins, "neotest") then require("neotest").summary.close() end
   if vim.tbl_contains(loaded_plugins, "trouble.nvim") then require("trouble").close() end
   if vim.tbl_contains(loaded_plugins, "nvim-tree.lua") then require("nvim-tree.api").tree.close() end
   if vim.tbl_contains(loaded_plugins, "nvim-dap") then require("dap").terminate() end
   require("close_buffers").delete { type = "nameless", force = true }
   require("close_buffers").delete { type = "hidden", force = true }
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

vim.api.nvim_create_autocmd({ "VimEnter" }, {
   group = vim.api.nvim_create_augroup("ChooseWorkspace", { clear = true }),
   callback = function()
      local home = vim.fn.expand "~"
      if #vim.api.nvim_get_vvar "argv" == 1 and vim.loop.cwd() == home then
         require("telescope").extensions.workspaces.workspaces()
      end
   end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
   group = vim.api.nvim_create_augroup("CleanupStuff", { clear = true }),
   callback = clean_workspace_up,
})

return {
   "natecraddock/workspaces.nvim",
   dependencies = {
      "natecraddock/sessions.nvim",
      opts = {
         session_filepath = vim.fn.stdpath "data" .. "/sessions",
         absolute = true,
      },
   },
   opts = function()
      return {
         mru_sort = false,
         hooks = {
            open_pre = function(_, path)
               clean_workspace_up()
               if not is_suppressed(path) then require("sessions").save(nil, { silent = true }) end
               vim.cmd "bd%"
               vim.cmd "clearjumps"
            end,
            open = function(_, path)
               local opts = { silent = true }
               if is_suppressed(path) then opts["autosave"] = false end
               require("sessions").load(nil, opts)
               deactivate_virtual_env()
               activate_virtual_env(path)
            end,
         },
      }
   end,
   lazy = true,
}
