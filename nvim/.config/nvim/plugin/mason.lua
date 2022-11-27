require("mason").setup()
require("mason-tool-installer").setup {
   ensure_installed = {
      "black",
      "codelldb",
      "css-lsp",
      "debugpy",
      "dockerfile-language-server",
      "fixjson",
      "flake8",
      "isort",
      "json-lsp",
      "lua-language-server",
      "markdownlint",
      "marksman",
      "pyright",
      "rust-analyzer",
      "stylua",
      "taplo",
      "yaml-language-server",
   },
   auto_update = true,
}

require("mason-lspconfig").setup_handlers {
   function(server_name) require("lspconfig")[server_name].setup {} end,
}
