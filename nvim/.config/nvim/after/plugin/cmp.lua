local ls = require "luasnip"
local cmp = require "cmp"
if cmp == nil then return end

local matches_before_cursor = function(start, match)
   local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(start or col, col):match(match) ~= nil
end

local function nvim_lsp_filter(entry, _) return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text" end

local in_import_sources = {
   { name = "nvim_lsp", entry_filter = nvim_lsp_filter },
   { name = "nvim_lsp_signature_help" },
}

local default_sources = {
   { name = "luasnip" },
   { name = "nvim_lsp", entry_filter = nvim_lsp_filter },
   { name = "nvim_lua" },
   { name = "path" },
   { name = "nvim_lsp_signature_help" },
   { name = "buffer", keyword_length = 5 },
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
      completer(in_import_scope() and in_import_sources or default_sources)
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

cmp.setup {
   enabled = function() return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer() end,
   snippet = {
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
   },
   mapping = mapping,
   formatting = {
      format = function(entry, vim_item)
         local menus = {
            nvim_lsp = "lsp",
            nvim_lua = "api",
            path = "pth",
            luasnip = "snp",
            buffer = "buf",
            cmdline = "cmd",
         }

         vim_item.menu = menus[entry.source.name]
         return vim_item
      end,
   },
   window = {
      completion = cmp.config.window.bordered { col_offset = 5 },
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
      { name = "buffer" },
   },
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "cmdline" },
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
