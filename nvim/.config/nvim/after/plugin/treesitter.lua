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
      if ok then vim.keymap.set("n", "S", require("iswap").iswap, { remap = true, buffer = true, desc = "Swap" }) end
   end,
})
