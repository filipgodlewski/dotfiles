---@type LazySpec
return {

  { "nvim-neotest/neotest-plenary" },

  {
    "nvim-neotest/neotest",
    optional = true,
    ---@type neotest.Config
    opts = {
      adapters = {
        ["neotest-plenary"] = {},
      },
    },
  },

  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "selene" })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        lua = { "selene" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
