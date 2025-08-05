---@module 'lazy'
---@type LazySpec
return {
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
