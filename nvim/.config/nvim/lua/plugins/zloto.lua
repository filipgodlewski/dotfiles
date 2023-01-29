return {
   dir = "~/personal/zloto.nvim",
   name = "zloto",
   lazy = false,
   priority = 1000,
   config = function(plugin)
      require(plugin.name).setup()
      vim.cmd "colorscheme zloto"
   end,
}
