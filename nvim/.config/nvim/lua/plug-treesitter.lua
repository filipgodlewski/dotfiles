require("nvim-treesitter.configs").setup {
   ensure_installed = {
      "comment", 
      "css", 
      "html", 
      "json", 
      "lua", 
      "python", 
      "regex", 
      "scss", 
      "toml", 
      "yaml",
   },
   highlight = {
      enable = true,
      custom_captures = {
         ["type.builtin.error"] = "TSTypeBuiltinError",
         ["type.builtin.warning"] = "TSTypeBuiltinWarning",
         ["type.operator.not"] = "TSTypeOperatorNot",
         ["text.ref"] = "TSRef",
      },
   },
   context_commentstring = {
      enable = true,
      config = {
         lua = "-- %s",
      }
   }
}
