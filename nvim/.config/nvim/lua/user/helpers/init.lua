local M = {}

M.default_opts = {
   prefix = "",
   mode = "n",
}

M.extend_opts = function(opts) return vim.tbl_deep_extend("force", M.default_opts, opts) end

M.deregister = function(mappings, opts)
   opts = M.extend_opts(opts or {})
   local all_mappings = {}
   for _, lhs in ipairs(mappings) do
      local mapping = opts.prefix .. lhs
      pcall(vim.api.nvim_del_keymap, opts.mode, mapping)
      all_mappings[lhs] = "which_key_ignore"
   end
   require("which-key").register(all_mappings, opts)
end

M.first_to_upper = function(s) return s:gsub("^%l", string.upper) end

M.cmd = function(c) return string.format("<cmd>%s<cr>", c) end

local setup_dap_breakpoint_mappings = function()
   local dap_prefix = "<localLeader>d"
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end

   local delete_breakpoints = function()
      M.deregister({ "d", "l", "t" }, { prefix = dap_prefix .. "b" })
      require("dap").clear_breakpoints()
   end

   require("dap").set_breakpoint(cond)
   require("which-key").register({
      d = { delete_breakpoints, "Delete breakpoints" },
      l = { function() require("telescope").extensions.dap.list_breakpoints() end, "List breakpoints" },
      t = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
   }, { prefix = dap_prefix .. "b" })
end

M.setup_dap_entrypoint = {
   name = "Debug",
   b = {
      name = "Breakpoint",
      a = { setup_dap_breakpoint_mappings, "Add" },
   },
   c = { function() require("dap").continue() end, "Start/Continue" },
}

M.setup_neotest_mappings = {
   name = "Neotest",
   f = { function() require("neotest").run.run { vim.fn.expand "%" } end, "Run file" },
   F = { function() require("neotest").run.run { vim.fn.expand "%", strategy = "dap" } end, "Run file (debug)" },
   t = { function() require("neotest").summary.toggle() end, "Toggle summary" },
   l = { function() require("neotest").run.run_last() end, "Run last" },
   L = { function() require("neotest").run.run_last { strategy = "dap" } end, "Run last (debug)" },
   k = { function() require("neotest").run.stop() end, "Kill run" },
   o = { function() require("neotest").output_panel.toggle() end, "Toggle output" },
   O = { function() require("neotest").output_panel.toggle() end, "Clear output" },
   r = { function() require("neotest").run.run() end, "Run" },
   R = { function() require("neotest").run.run { strategy = "dap" } end, "Run (debug)" },
   w = { function() require("neotest").watch.toggle() end, "Toggle watcher" },
}

M.get_loaded_lazy_plugins = function()
   return vim.tbl_flatten(vim.tbl_map(function(v)
      if v._.loaded then return v.name end
   end, require("lazy").plugins()))
end

M.did_load_lazy_plugin = function(name)
   local loaded_plugins = M.get_loaded_lazy_plugins()
   return vim.tbl_contains(loaded_plugins, name)
end

return M
