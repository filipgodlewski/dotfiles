---@type LazySpec
return {

  { "folke/flash.nvim", enabled = false },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      opts.defaults.prompt_prefix = "   "
      opts.defaults.selection_caret = "    "
      opts.defaults.multi_icon = " "
      opts.defaults.entry_prefix = "     "
    end,
    keys = {
      { "<leader>/", ":lua require('config.util').grep()<cr>", desc = "Grep (root dir)" },
      { "<leader><space>", ":lua require('config.util').files()<cr>", desc = "Find Files (root dir)" },
      { "<leader>ff", ":lua require('config.util').files()<cr>", desc = "Find Files (root dir)" },
      { "<leader>fF", ":lua require('config.util').files(true)<cr>", desc = "Find Files (cwd)" },
      { "<leader>sg", ":lua require('config.util').grep()<cr>", desc = "Grep (root dir)" },
      { "<leader>sG", ":lua require('config.util').grep(true)<cr>", desc = "Grep (cwd)" },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@return DiffViewOptions
    opts = function()
      local diffview = require("diffview")
      return {
        keymaps = {
          view = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
          file_panel = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
          file_history_panel = { { "n", "q", diffview.close, { desc = "Close diff view" } } },
        },
      }
    end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "willothy/flatten.nvim",
    opts = {
      one_per = { kitty = true },
    },
    priority = 1001,
  },

  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<CMD>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Next word" },
      { "e", "<CMD>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Next end of word" },
      { "b", "<CMD>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Previous word" },
      { "ge", "<CMD>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Previous end of word" },
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    version = "2.*",
    opts = function()
      local opts = require("window-picker.config")
      opts.hint = "floating-big-letter"
      opts.show_prompt = false
      vim.list_extend(opts.filter_rules.bo.buftype, { "nofile" })
      return opts
    end,
  },

  {
    "tpope/vim-abolish",
    cmd = { "S", "Abolish" },
    keys = {
      { "crc", desc = "camelCase" },
      { "crp", desc = "PascalCase" },
      { "crs", desc = "snake_case" },
      { "cru", desc = "SNAKE_UPPERCASE" },
      { "crk", desc = "kebab-case (not usually reversible)" },
      { "cr.", desc = "dot.case (not usually reversible)" },
    },
  },

  {
    "folke/which-key.nvim",
    ---@type Options
    opts = {
      key_labels = {
        ["<space>"] = "␣",
        ["<cr>"] = "󰌑",
        ["<tab>"] = "󰌒",
        ["<M-Bslash>"] = [[󰘵 + \]],
        ["<leader>"] = "󰘳",
        ["<localLeader>"] = "󰜞",
      },
      defaults = {
        ["cr"] = { name = "+convert" },
        ["z"] = { name = "+z-commands" },
        ["<leader>"] = { name = "leader" },
        ["<localLeader>"] = { name = "Local Leader" },
      },
    },
  },
}
