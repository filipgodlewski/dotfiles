local helpers = require "user.helpers"
local qf_prefix = "<localLeader>C"

local M = {}

local function trouble_qf_refresh() require("trouble").refresh { auto = true, provider = "qf" } end

M.clear = function()
   vim.cmd "cexpr []"
   vim.schedule(require("trouble").close)
   helpers.deregister({ "Q", "f", "F", "r", "t", "u" }, { prefix = qf_prefix })
   helpers.deregister { qf_prefix }
end

M.filter = function(mode)
   local filter = vim.fn.input "Filter by (vim regex): "
   if filter == "" then return end
   vim.cmd "packadd cfilter"
   vim.cmd(string.format("Cfilter%s %s", mode, filter))
   trouble_qf_refresh()
end

M.replace = function()
   local old = vim.fn.input("Old: ", vim.fn.getreg "c")
   local new = vim.fn.input("New: ", old)
   if old == "" and new == "" then return end
   vim.cmd(string.format("cdo s/%s/%s/ | update", old, new))
   require("which-key").register { [qf_prefix .. "u"] = { M.undo, "Undo" } }
end

M.undo = function()
   vim.cmd "cfdo normal u | update"
   helpers.deregister { qf_prefix .. "u" }
end

M.search = function(search_fn)
   local ft_mask = vim.fn.input("File mask: ", "**/*")
   ft_mask = ft_mask == "" and {} or ft_mask
   require("telescope.builtin")[search_fn] { glob_pattern = ft_mask }
end

M.setup_search = function(prompt_bufnr)
   require("telescope.actions").smart_send_to_qflist(prompt_bufnr)
   require("trouble").open "quickfix"
   require("trouble").refresh { auto = true, provider = "qf" }
   require("which-key").register({
      name = "Search and replace",
      Q = { M.clear, "Clean up Quickfix list" },
      f = { function() M.filter "" end, "Filter by matching" },
      F = { function() M.filter "!" end, "Filter by not matching" },
      r = { M.replace, "Replace in-place" },
      t = { function() require("trouble").toggle "quickfix" end, "Toggle Quickfix list" },
   }, { prefix = qf_prefix })
end

return M
