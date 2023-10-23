local helpers = require "user.helpers"

local setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end

   local delete_breakpoints = function()
      helpers.deregister({ "d", "l", "t" }, { prefix = "<localLeader>", buffer = 0 })
      require("dap").clear_breakpoints()
   end

   require("dap").set_breakpoint(cond)
   require("which-key").register({
      d = { delete_breakpoints, "Delete breakpoints" },
      l = { function() require("telescope").extensions.dap.list_breakpoints() end, "List breakpoints" },
      t = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
   }, { prefix = "<localLeader>", buffer = 0 })
end

local LANG_CFGS = {
   _ = {
      ["in"] = function()
         require("which-key").register({
            b = { setup_breakpoint, "Put a breakpoint" },
            c = { function() require("dap").continue() end, "Start/Continue debugger" },
         }, { prefix = "<localLeader>" })
      end,
      ["out"] = function() helpers.deregister({ "b", "c" }, { prefix = "<localLeader>" }) end,
   },
   python = {
      ["in"] = function()
         require("which-key").register({
            u = { require("neotest").summary.toggle, "Toggle Neotest" },
         }, { prefix = "<leader>" })
      end,
      ["out"] = function() helpers.deregister({ "u" }, { prefix = "<leader>" }) end,
   },
   go = {
      ["in"] = function()
         require("which-key").register({
            name = "Run",
            l = { require("dap-go").debug_last, "Last" },
            s = { require("dap-go").debug_test, "Selected" },
         }, { prefix = "<localLeader>r" })
      end,
      ["out"] = function() helpers.deregister({ "l", "s" }, { prefix = "<localLeader>r" }) end,
   },
}

local FTS = vim.tbl_filter(function(v) return v ~= "_" end, vim.tbl_keys(LANG_CFGS))

local get_condition = function(ft)
   local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
   if ft == "_" then return vim.tbl_contains(FTS, buf_ft) end
   return buf_ft == ft
end

local get_callback = function(ft, suffix, fn)
   if suffix == "in" then
      if get_condition(ft) then fn() end
   else
      if not get_condition(ft) then fn() end
   end
end

local create_mapping = function(ft, suffix, fn)
   local callback = function() get_callback(ft, suffix, fn) end
   local prefix = ft == "_" and "base" or ft
   vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
      group = vim.api.nvim_create_augroup(
         helpers.first_to_upper(prefix) .. "DebugMappings" .. helpers.first_to_upper(suffix),
         { clear = true }
      ),
      callback = callback,
   })
end

for ft, cfgs in pairs(LANG_CFGS) do
   for suffix, fn in pairs(cfgs) do
      create_mapping(ft, suffix, fn)
   end
end
