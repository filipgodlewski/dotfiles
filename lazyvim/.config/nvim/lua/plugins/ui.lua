---@type LazySpec
return {

  {
    "nvimdev/dashboard-nvim",
    enabled = false,
    optional = true,
    opts = function(_, opts)
      opts.config.header = { "", "Hello, again.", "" }

      local button = { action = "Mason", desc = " Mason", icon = "󱁤 ", key = "m", key_format = "  %s" }
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      table.insert(opts.config.center, #opts.config.center, button)
      opts.config.center[1].action = "lua require('config.util').files()"
      opts.config.center[4].action = "lua require('config.util').grep()"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    optional = true,
    ---@type dapui.Config
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.4 },
            { id = "stacks", size = 0.4 },
            { id = "watches", size = 0.2 },
          },
          size = 50,
          position = "right",
        },
        {
          elements = {
            "breakpoints",
            "repl",
            "console",
          },
          size = 0.2,
          position = "bottom",
        },
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = { width = 130 },
      plugins = {
        kitty = { enabled = true },
      },
      on_open = function()
        vim.env.ZEN_MODE_ON = true
      end,
      on_close = function()
        vim.env.ZEN_MODE_ON = nil
      end,
    },
    cmd = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
    },
  },
}
