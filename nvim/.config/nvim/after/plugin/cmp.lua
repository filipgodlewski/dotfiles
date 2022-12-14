local ls = require "luasnip"
local cmp = require "cmp"
if cmp == nil then return end

local matches_before_cursor = function(start, match)
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(start or col, col):match(match) ~= nil
end

local function nvim_lsp_filter(entry, _)
   local kind = entry:get_kind()
   local lk_types = { "Text", "Snippet" }
   local types = require("cmp.types").lsp.CompletionItemKind
   if vim.tbl_contains(lk_types, types[kind]) then return false end
   return true
end

local lsp_sources = {}
local default_sources = {
   { name = "luasnip" },
   { name = "nvim_lsp", entry_filter = nvim_lsp_filter },
   { name = "nvim_lsp_signature_help" },
   { name = "nvim_lua" },
   { name = "path" },
   { name = "buffer" },
}

local import_matches = {
   python = { "import%s*$", "^%s*from%s*$" },
}

local function in_import_scope()
   for _, value in ipairs(import_matches[vim.bo.filetype]) do
      if matches_before_cursor(1, value) then return true end
   end
   return false
end

local function completer(sources) cmp.complete { config = { sources = sources } } end

local mapping = cmp.mapping.preset.insert {
   ["<C-s>"] = cmp.mapping(function(_)
      cmp.close()
      completer(in_import_scope() and lsp_sources or default_sources)
   end, { "i", "s" }),
   ["<C-l>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
   ["<C-d>"] = cmp.mapping.scroll_docs(4),
   ["<C-u>"] = cmp.mapping.scroll_docs(-4),
   ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
         cmp.select_next_item()
      elseif ls.expand_or_jumpable() then
         ls.expand_or_jump()
      elseif not matches_before_cursor(nil, "%s") then
         cmp.complete()
      else
         fallback()
      end
   end, { "i", "s" }),
   ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
         cmp.select_prev_item()
      elseif ls.jumpable(-1) then
         ls.jump(-1)
      else
         fallback()
      end
   end, { "i", "s" }),
   ["<C-t>"] = cmp.mapping(function(fallback)
      if ls.choice_active() then
         ls.change_choice(1)
      else
         fallback()
      end
   end, { "i", "s" }),
}

local kinds = {
   Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "ﰠ",
   Variable = "",
   Class = "ﴯ",
   Interface = "",
   Module = "",
   Property = "ﰠ",
   Unit = "",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "פּ",
   Event = "",
   Operator = "",
   TypeParameter = "",
}

cmp.setup {
   enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
   end,
   snippet = {
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
   },
   mapping = mapping,
   formatting = {
      fields = { "kind", "abbr", "menu" },
      mode = "symbol_text",
      format = function(entry, vim_item)
         local item = entry:get_completion_item()
         print(vim.inspect(item.detail))

         if vim.tbl_contains({ "path" }, entry.source.name) then
            if item.data.type == "directory" then
               vim_item.kind = kinds.Folder
               return vim_item
            end
            local icon, hl_group = require("nvim-web-devicons").get_icon(item.label)
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
         end
         vim_item.kind = kinds[vim_item.kind] or ""
         vim_item.abbr = vim_item.abbr:match "[^(]+"
         return vim_item
      end,
   },
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   sources = default_sources,
   sorting = {
      comparators = {
         cmp.config.compare.recently_used,
         cmp.config.compare.score,
         require("cmp-under-comparator").under,
         cmp.config.compare.scopes,
         cmp.config.compare.locality,
         cmp.config.compare.kind,
      },
   },
}

cmp.setup.cmdline({ "/", "?" }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "nvim_lsp_document_symbol" },
      { name = "buffer" },
   },
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "cmdline" },
      { name = "nvim_lsp_document_symbol" },
      { name = "path" },
   },
})

cmp.setup.filetype("gitcommit", {
   sources = {
      { name = "buffer" },
   },
})

cmp.setup.filetype("toml", {
   sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
   },
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
   sources = {
      { name = "dap" },
   },
})
