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
   which_key.register(all_mappings)
end

local function trouble_qf_refresh() trouble.refresh { auto = true, provider = "qf" } end

M.clear = function()
   vim.cmd "cexpr []"
   vim.schedule(trouble.close)
   M.deregister({ "c", "f", "r", "t", "u" }, { prefix = "<leader>c" })
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

M.put_cmd = function(cmd)
   local bufname = "[Information]"
   local bufnr = vim.fn.bufnr("\\" .. bufname)
   if bufnr > 0 then vim.cmd(string.format("bw! %s", bufnr)) end

   bufnr = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_name(bufnr, bufname)

   vim.cmd "below new"
   vim.cmd "wincmd J"
   vim.api.nvim_win_set_height(0, 10)
   vim.api.nvim_win_set_buf(0, bufnr)
   vim.cmd(string.format([[put =execute('%s')]], cmd))
   which_key.register({ q = { "<CMD>bw!<CR>", string.format("Close %s", bufname) } }, { buffer = bufnr })
end

M.setup_search = function(prompt_bufnr)
   actions.smart_send_to_qflist(prompt_bufnr)
   trouble.open "quickfix"
   trouble.refresh { auto = true, provider = "qf" }
   which_key.register({
      name = "Search [ACTIVE]",
      c = { M.clear, "Clean" },
      f = { M.filter, "Cfilter" },
      r = { M.replace, "Replace" },
      t = { function() trouble.toggle "quickfix" end, "Toggle" },
   }, { prefix = "<leader>c" })
end

M.delete_breakpoints = function()
   dap.clear_breakpoints()
   M.deregister({ "d", "l", "t" }, { prefix = "<leader>b" })
end

M.setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end
   dap.set_breakpoint(cond)
   which_key.register({
      name = "Breakpoint [ACTIVE]",
      d = { M.delete_breakpoints, "Deactivate" },
      l = { telescope.extensions.dap.list_breakpoints, "List" },
      t = { dap.toggle_breakpoint, "Toggle" },
   }, { prefix = "<leader>b" })
end

M.font_sizes = {
   macbook_pro_16 = 12,
   mac_mini = 16,
   big = 24,
   gigantic = 32,
}

M.change_alacritty_font_size = function()
   local function format_item(item)
      local words = vim.split(item, "_")
      local capitalized_words = {}
      for _, word in ipairs(words) do
         local _word = string.gsub(word, "^%l", string.upper)
         table.insert(capitalized_words, _word)
      end
      return string.format("%s (%s)", table.concat(capitalized_words, " "), M.font_sizes[item])
   end

   local function on_choice(choice)
      pcall(vim.cmd, "argdelete")
      vim.cmd "argadd ~/.config/alacritty/alacritty.yml"
      local cmd = [[silent argdo %%s/\v(\s+size:) \d+/\1 %s/e | update | b# | bd# ]]
      vim.cmd(string.format(cmd, M.font_sizes[choice]))
      vim.cmd "argdelete"
   end

   local opts = { prompt = "Select Alacritty Font Size", format_item = format_item }

   vim.ui.select(vim.tbl_keys(M.font_sizes), opts, on_choice)
end

return M
