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

return M
