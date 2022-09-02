require("nvim-treesitter.configs").setup({
   ensure_installed = { "comment", "css", "html", "json", "lua", "python", "regex", "scss", "toml", "yaml" },
   highlight = { enable = true },
   context_commentstring = { enable = true },
})

require("treesitter-context").setup()
