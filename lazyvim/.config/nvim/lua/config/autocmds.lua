---@class NvimAucmdEvent
---@field buf integer buffer number that matched the event
---@field event string vim event that triggered callback
---@field file string file name that the trigger happened for
---@field group integer augroup number
---@field id integer autocmd id
---@field match string full match, e.g. absolute path

local H = require("config.legend")

---@param name string
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "requirements", "*requirements.txt" },
  group = augroup("pip_requirements"),
  callback = function()
    pcall(vim.treesitter.start, 0, "requirements")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "neotest-summary",
    "Outline",
  },
  group = augroup("which_key_help"),
  ---@type fun(event: NvimAucmdEvent)
  callback = function(event)
    require("which-key").register({ ["<leader>?"] = H[event.match] }, { buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup("leave_zenmode"),
  callback = function()
    if vim.env.ZEN_MODE_ON then
      require("zen-mode").close()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  group = augroup("conceal_off"),
  command = "setlocal conceallevel=0",
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = "*/obsidian-vaults/*.md",
  group = augroup("obsidian_exceptional_opts"),
  command = "setlocal conceallevel=2",
})
