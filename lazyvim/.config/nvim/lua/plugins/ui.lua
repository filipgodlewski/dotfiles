---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@module 'snacks'
    ---@param opts snacks.Config
    opts = function(_, opts)
      local mason_key = { icon = "󱌢 ", key = "m", desc = "Mason", action = ":Mason" } ---@type snacks.dashboard.Item
      table.insert(opts.dashboard.preset.keys, #opts.dashboard.preset.keys, mason_key)
      opts.dashboard.preset.header = ""
      return opts
    end,
  },
}
