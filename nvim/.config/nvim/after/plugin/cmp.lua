local ls = require("luasnip")
local select_choice = require("luasnip.extras.select_choice")
local cmp = require("cmp")

local has_words_before = function()
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local mapping = cmp.mapping.preset.insert({
   ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
   ["<C-space>"] = cmp.mapping.complete(),
   ["<C-e>"] = cmp.mapping.close(),
   ["<C-d>"] = cmp.mapping.scroll_docs(4),
   ["<C-u>"] = cmp.mapping.scroll_docs(-4),
   ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
         cmp.select_next_item()
      elseif ls.expand_or_locally_jumpable() then
         ls.expand_or_jump()
      elseif has_words_before() then
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
   ["<C-l>"] = cmp.mapping(function(fallback)
      if ls.choice_active() then
         select_choice()
      else
         fallback()
      end
   end, { "i", "s" }),
})

cmp.setup({
   completion = { completeopt = "menu,menuone,noinsert" },
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end
   },
   mapping = mapping,
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   sources = {
      { name = "luasnip" },
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "path" },
      { name = "buffer" },
   },
   sorting = {
      comparators = {
         cmp.config.compare.sort_text,
         cmp.config.compare.offset,
         cmp.config.compare.score,
         cmp.config.compare.order,
      }
   }
})

cmp.setup.cmdline("/", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "buffer" },
   }
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "cmdline" },
      { name = "path" },
   }
})

cmp.setup.filetype("gitcommit", {
   sources = {
      { name = "conventionalcommits" },
      { name = "luasnip" },
      { name = "buffer" },
   }
})

cmp.setup.filetype("toml", {
   sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
   }
})

cmp.setup.filetype("TelescopePrompt", { enabled = false, })
