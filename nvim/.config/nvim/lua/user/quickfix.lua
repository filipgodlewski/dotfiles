local helpers = require "user.helpers"

local M = {}

local function trouble_qf_refresh() require("trouble").refresh { auto = true, provider = "qf" } end

M.clear = function()
   vim.cmd "cexpr []"
   vim.schedule(require("trouble").close)
   helpers.deregister({ "c", "f", "r", "t", "u" }, { prefix = "<leader>c" })
end

M.filter = function()
   local filter = vim.fn.input "Filter by: "
   if filter == "" then return end
   vim.cmd "packadd cfilter"
   vim.cmd(string.format("Cfilter %s", filter))
   trouble_qf_refresh()
end

M.replace = function()
   local old = vim.fn.input("Old: ", vim.fn.getreg "c")
   local new = vim.fn.input("New: ", old)
   if old == "" and new == "" then return end
   vim.cmd(string.format("cdo s/%s/%s/ | update", old, new))
   require("which-key").register { ["<leader>cu"] = { M.undo, "Undo" } }
end

M.undo = function()
   vim.cmd "cfdo normal u | update"
   helpers.deregister { "<leader>cu" }
end

M.search = function()
   local ft_mask = vim.fn.input("File mask: ", "**/*")
   ft_mask = ft_mask == "" and {} or ft_mask
   require("telescope.builtin").live_grep { glob_pattern = ft_mask }
end

M.setup_search = function(prompt_bufnr)
   require("telescope.actions").smart_send_to_qflist(prompt_bufnr)
   require("trouble").open "quickfix"
   require("trouble").refresh { auto = true, provider = "qf" }
   require("which-key").register({
      name = "Search [ACTIVE]",
      c = { M.clear, "Clean up Quickfix list" },
      f = { M.filter, "Filter results" },
      r = { M.replace, "Replace in-place" },
      t = { function() require("trouble").toggle "quickfix" end, "Toggle Quickfix list" },
   }, { prefix = "<leader>c" })
end

require("which-key").register({
   name = "Quickfix search",
   s = { M.search, "Search for issues" },
}, { prefix = "<leader>c" })

return M
