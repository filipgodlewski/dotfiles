local telescope = require "telescope"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local dap = require "dap"
local trouble = require "trouble"
local which_key = require "which-key"

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
      all_mappings[mapping] = "which_key_ignore"
   end
   require("which-key").register(all_mappings)
end

local function trouble_qf_refresh() trouble.refresh { auto = true, provider = "qf" } end

M.clear = function()
   vim.cmd "cexpr []"
   vim.schedule(trouble.close)
   M.deregister({ "c", "f", "r", "s", "t", "u" }, { prefix = "<leader>c" })
   which_key.register { ["<leader>c"] = { M.search, "Search" } }
end

M.filter = function()
   local filter = vim.fn.input "Filter by: "
   if filter == "" then return end
   vim.cmd(string.format("Cfilter %s", filter))
   trouble_qf_refresh()
end

M.replace = function()
   local old = vim.fn.input("Old: ", vim.fn.getreg "c")
   local new = vim.fn.input("New: ", old)
   if old == "" and new == "" then return end
   vim.cmd(string.format("cdo s/%s/%s/ | update", old, new))
   which_key.register { ["<leader>cu"] = { M.undo, "Undo" } }
end

M.undo = function()
   vim.cmd "cfdo normal u | update"
   M.deregister { "<leader>cu" }
end

M.search = function()
   local ft_mask = vim.fn.input "File mask: "
   ft_mask = ft_mask == "" and {} or ft_mask
   builtin.live_grep { glob_pattern = ft_mask }
end

M.put_cmd = function(cmd) vim.cmd(string.format([[15new +put\ =\ execute('%s')|set\ nornu\ nonu]], cmd)) end

M.setup_search = function(prompt_bufnr)
   actions.smart_send_to_qflist(prompt_bufnr)
   trouble.open "quickfix"
   trouble.refresh { auto = true, provider = "qf" }
   M.deregister { "<leader>c" }
   which_key.register({
      name = "Search [ACTIVE]",
      c = { M.clear, "Clean" },
      f = { M.filter, "Cfilter" },
      r = { M.replace, "Replace" },
      s = { M.search, "Search" },
      t = { function() trouble.toggle "quickfix" end, "Toggle" },
   }, { prefix = "<leader>c" })
end

M.setup_debugger = function()
   dap.continue()
   if dap.session() == nil then return end
   require("neotest").summary.close()
   M.deregister { "<leader>d" }
   which_key.register({
      d = {
         name = "Debug",
         c = { dap.continue, "Continue" },
         k = { dap.terminate, "Kill" },
      },
      s = {
         name = "Step",
         b = { dap.step_back, "Step back" },
         d = { dap.step_into, "Step into" },
         r = { dap.step_over, "Step over" },
         t = { dap.run_to_cursor, "To cursor" },
         u = { dap.step_out, "Step out" },
      },
      f = {
         name = "Frames",
         d = { dap.down, "Down" },
         l = { telescope.extensions.dap.frames, "List" },
         u = { dap.up, "Up" },
      },
   }, { prefix = "<leader>" })
end

return M
