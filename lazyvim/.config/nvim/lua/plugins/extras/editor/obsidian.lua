---@type LazySpec
return {

  {
    "epwalsh/obsidian.nvim",
    event = {
      "BufRead " .. vim.fn.expand("~") .. "/Documents/obsidian-vaults/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/obsidian-vaults/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        ---@type obsidian.Workspace
        {
          name = "personal",
          path = vim.fn.expand("~") .. "/Documents/obsidian-vaults/personal",
        },
        ---@type obsidian.Workspace
        {
          name = "work",
          path = vim.fn.expand("~") .. "/Documents/obsidian-vaults/work",
        },
      },
      ---@type obsidian.config.TemplateOpts
      templates = {
        subdir = "templates",
      },
      ---@type fun(title: string): string
      note_id_func = function(title)
        if title == nil then
          return require("obsidian.util").zettel_id()
        end
        local time = tostring(os.time()) .. "-"
        return (time .. title):gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      end,
    },
  },
}
