return {
   "nathom/filetype.nvim", -- load ft faster
   "stevearc/dressing.nvim",
   { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true, event = "BufEnter" },
   { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true, lazy = true },
   { "j-hui/fidget.nvim", config = true }, -- cool spinner for loaders
   { "kazhala/close-buffers.nvim", opts = { preserve_window_layout = { "this" } }, lazy = true },
   { "mbbill/undotree", cmd = "UndotreeToggle" },
   { "mizlan/iswap.nvim", config = true, lazy = true },
   { "simrat39/rust-tools.nvim", ft = "rust", config = true },
   { "tpope/vim-abolish", cmd = "S" }, -- better Search & Replace
}

-- Stephan Schiffman - Negotiation Techniques (That really work!)
-- Robert Cialdini - Influnce - the psychology of persuasion
-- Robert Mnookin - Bargaining with the Devil (When to negotiate, when to fight)
-- Brian Tracy - The Art of Closing the Sale
-- Grant Cardone - Sell or be sold (How to get your way in business and in life)
-- Robert Greene - The laws of human nature
-- Roger Fisher & William Ury - Getting to Yes (Negotiating agreement without giving in)
-- Morgan Housel - The Psychology of Money
-- Ray Dalio - The changing world order (Why nations succeed and fail)
