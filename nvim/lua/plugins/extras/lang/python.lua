---@module 'lazy'
---@type LazySpec
return {

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("uv")
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    optional = true,
    enabled = true,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          python = ".venv/bin/python",
        },
      },
    },
  },
}
