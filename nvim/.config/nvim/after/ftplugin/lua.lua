vim.opt_local.shiftwidth = 3
vim.opt_local.softtabstop = 3
vim.opt_local.tabstop = 3
vim.opt_local.path = { ".", "**", vim.fn.stdpath "data" .. "/lazy", "/usr/include", "" }

-- stolen from LunarVim's config

-- Search for lua traditional include paths.
-- This mimics how require internally works.
local function include_paths(fname)
   local paths = string.gsub(package.path, "%?", fname)
   for path in string.gmatch(paths, string.format("[^%s]+", "%;")) do
      if vim.fn.filereadable(path) == 1 then return path end
   end
end

-- Search for nvim lua include paths
local function include_rtpaths(fname)
   local function get_path(path_table)
      local path = table.concat(path_table, "/")
      if vim.fn.filereadable(path) == 1 then return path end
   end

   for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
      local f = get_path { path, "lua", string.format("%s.lua", fname) } or get_path { path, "lua", fname, "init.lua" }
      if f then return f end
   end
end

function FindRequiredPath(module)
   local fname = vim.fn.substitute(module, "\\.", "/", "g")
   local f = include_paths(fname) or include_rtpaths(fname)
   if f then return f end
end

vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = "v:lua.FindRequiredPath(v:fname)"
