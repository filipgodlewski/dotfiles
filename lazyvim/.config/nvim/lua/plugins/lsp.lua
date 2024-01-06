---@type LazySpec
return {

  { "smjonas/inc-rename.nvim", opts = {} },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {},
      },
    },
  },
}
