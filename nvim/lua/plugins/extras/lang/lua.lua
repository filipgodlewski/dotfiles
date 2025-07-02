---@module 'lazy'
---@type LazySpec
return {
  { "nvim-neotest/neotest-plenary" },

  {
    "nvim-neotest/neotest",
    optional = true,
    opts = { adapters = { "neotest-plenary" } },
  },

  {
    "williamboman/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "selene" } },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
      },
      linters = {
        selene = {
          condition = function()
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function()
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
      },
    },
  },
}
