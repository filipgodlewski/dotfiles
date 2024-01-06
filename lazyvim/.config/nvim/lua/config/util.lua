local Util = require("lazyvim.util")

---@class UserUtil
local M = {}

---@param cwd boolean
M.files = function(cwd)
  local opts = { hidden = true }
  if cwd then
    opts.cwd = false
  end
  Util.telescope("files", opts)()
end

---@param cwd boolean
M.grep = function(cwd)
  local opts = { hidden = true, glob_pattern = vim.fn.input({ prompt = "File mask: ", default = "**/*" }) }
  if cwd then
    opts.cwd = false
  end
  Util.telescope("live_grep", opts)()
end

---@param entry cmp.Entry
---@return boolean
local nvim_lsp_filter = function(entry, _)
  local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
  return not vim.tbl_contains({ "Text", "Snippet" }, kind)
end

---@type cmp.SourceConfig
M.nvim_lsp_filtered = { name = "nvim_lsp", entry_filter = nvim_lsp_filter }

---@param opts cmp.ConfigSchema
---@param name string
---@return integer?
M.cmp_source_index = function(opts, name)
  for i, source in ipairs(opts.sources) do
    if source.name == name then
      return i
    end
  end
end

---@return table<string, cmp.Mapping>
M.get_cmp_mappings = function()
  local cmp = require("cmp")
  return {
    ["<C-n>"] = function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end,
    ["<C-p>"] = function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete({ config = { sources = { { name = "buffer" } } } })
      end
    end,
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-l>"] = {
      i = function()
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          cmp.complete({ config = { sources = { { name = "luasnip" } } } })
        end
      end,
    },
  }
end

return M
