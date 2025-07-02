return {
  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      {
        "<leader>gD",
        function()
          Snacks.terminal({ "gh", "dash" }, { win = { minimal = true, border = "rounded" } })
        end,
        desc = "Toggle gh-dash",
      },
    },
  },
}
