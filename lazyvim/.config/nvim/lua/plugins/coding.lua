local Util = require("config.util")

---@type LazySpec
return {

  {
    "L3MON4D3/LuaSnip",
    optional = true,
    dependencies = { "filipgodlewski/luasnip-ts-snippets.nvim", opts = {} },
    opts = {
      update_events = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged,InsertLeave",
      enable_autosnippets = false,
    },
    keys = {
      -- stylua: ignore
      { "<C-t>", function() pcall(require("luasnip").change_choice, 1) end, mode = { "i", "s" } },
    },
  },

  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = { use_default_keymaps = false },
    keys = {
      { "<leader>ct", "<CMD>TSJToggle<CR>", desc = "Toggle node" },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "LiadOz/nvim-dap-repl-highlights",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          optional = true,
          ---@param opts TSConfig
          opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "dap_repl" })
          end,
        },
        opts = {},
      },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    ---@param opts dapui.Config
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
          Util.nvim_lsp_filtered,
          { name = "buffer" },
        },
      })
    end,
  },

  {
    "nvim-cmp",
    optional = true,
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "lukas-reineke/cmp-under-comparator",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      table.insert(opts.sorting.comparators, 1, require("cmp-under-comparator").under)
      opts.mapping = cmp.mapping.preset.insert(Util.get_cmp_mappings())
      opts.sources = cmp.config.sources({
        Util.nvim_lsp_filtered,
        { name = "path" },
      })
    end,
  },
}
