return {
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    config = function()
      require("dap-python").setup("debugpy-adapter")
      table.insert(require("dap").configurations.python, 1, {
        type = "python",
        request = "launch",
        name = "file:root",
        program = "${file}",
        cwd = "${workspaceFolder}",
      })
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
      formatters = {
        pyupgrade = {
          command = "pyupgrade",
          args = {
            "--exit-zero-even-if-changed",
            "$FILENAME",
          },
          stdin = false,
          cwd = require("conform.util").root_file({
            "pyproject.toml",
            "requirements.txt",
          }),
        },
      },
    },
  },
}
