local which_key = require "which-key"
local my_helpers = require "my.helpers"
require("nvim-treesitter.configs").setup {
   ensure_installed = {
      "comment",
      "css",
      "gitcommit",
      "gitignore",
      "html",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "rust",
      "scss",
      "sql",
      "toml",
      "yaml",
   },
   highlight = { enable = true },
   context_commentstring = {
      enable = true,
      enable_autocmd = false,
   },
   query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
   },
}

require("treesitter-context").setup {
   patterns = {
      lua = {
         "function_definition",
      },
   },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
   group = vim.api.nvim_create_augroup("TSAttach", { clear = true }),
   callback = function()
      local ok, _ = pcall(vim.treesitter.get_parser, 0)
      if ok then
         which_key.register { S = { require("iswap").iswap, "Swap" } }
      else
         my_helpers.deregister { "S" }
      end
   end,
})
