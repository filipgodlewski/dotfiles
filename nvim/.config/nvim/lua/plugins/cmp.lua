local matches_before_cursor = function(start, match)
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(start or col, col):match(match) ~= nil
end

local function nvim_lsp_filter(entry, _)
   local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
   return not vim.tbl_contains({ "Text", "Snippet" }, kind)
end

local minimal_sources = {
   { name = "nvim_lsp", entry_filter = nvim_lsp_filter },
   { name = "nvim_lsp_signature_help" },
}

local extended_sources = {
   { name = "nvim_lua" },
   { name = "path" },
   { name = "buffer" },
}

local combined_sources = vim.deepcopy(minimal_sources)
vim.list_extend(combined_sources, extended_sources)

local context_matches = {
   python = {
      treesitter = { "import_from_statement", "import_statement" },
      regex = { "^%s*from%s*$" },
   },
}

local function get_context_sources()
   local ctx = context_matches[vim.bo.filetype]
   if not ctx then return combined_sources end

   local node_type = vim.treesitter.get_node():type()
   if vim.tbl_contains(ctx.treesitter, node_type) then return minimal_sources end

   for _, value in ipairs(ctx.regex) do
      if matches_before_cursor(1, value) then return minimal_sources end
   end

   return combined_sources
end

local cmdline_mappings = {
   ["<Tab>"] = { c = function() end },
   ["<S-Tab>"] = { c = function() end },
}
local kinds = {
   Text = "",
   Method = "󰆧",
   Function = "󰊕",
   Constructor = "",
   Field = "󰇽",
   Variable = "󰂡",
   Class = "󰠱",
   Interface = "",
   Module = "",
   Property = "󰜢",
   Unit = "",
   Value = "󰎠",
   Enum = "",
   Keyword = "󰌋",
   Snippet = "",
   Color = "󰏘",
   File = "󰈙",
   Reference = "",
   Folder = "󰉋",
   EnumMember = "",
   Constant = "󰏿",
   Struct = "",
   Event = "",
   Operator = "󰆕",
   TypeParameter = "󰅲",
}

return {
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-nvim-lsp-document-symbol",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-path",
         "rcarriga/cmp-dap",
         "saadparwaiz1/cmp_luasnip",
         "lukas-reineke/cmp-under-comparator",
      },
      opts = function()
         local cmp = require "cmp"
         local types = require "cmp.types"

         local mapping = cmp.mapping.preset.insert {
            ["<CR>"] = cmp.mapping {
               i = function(fallback)
                  if cmp.visible() and cmp.get_active_entry() then
                     cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                  else
                     fallback()
                  end
               end,
               s = cmp.mapping.confirm { select = true },
            },
            ["<C-l>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-n>"] = cmp.mapping(function(fallback)
               local luasnip = require "luasnip"
               if cmp.visible() then
                  cmp.select_next_item { behavior = types.cmp.SelectBehavior.Insert }
               elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
               elseif matches_before_cursor(nil, "%s") then
                  cmp.complete { config = { sources = get_context_sources() } }
               else
                  fallback()
               end
            end, { "i" }),
            ["<C-p>"] = cmp.mapping(function(fallback)
               local luasnip = require "luasnip"
               if cmp.visible() then
                  cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }
               elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
               else
                  fallback()
               end
            end, { "i" }),
            ["<C-t>"] = cmp.mapping(function(fallback)
               local luasnip = require "luasnip"
               if luasnip.choice_active() then
                  luasnip.change_choice(1)
               else
                  fallback()
               end
            end, { "i", "s" }),
         }

         return {
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

                  if vim.tbl_contains({ "path" }, entry.source.name) then
                     if item.data.type == "directory" then
                        vim_item.kind = string.format("%s Dir ", kinds.Folder)
                        return vim_item
                     end
                     local icon, hl_group = require("nvim-web-devicons").get_icon(item.label)
                     vim_item.kind = string.format("%s %s ", icon, vim_item.kind)
                     vim_item.kind_hl_group = hl_group
                     return vim_item
                  end
                  vim_item.kind = string.format("%s %s ", kinds[vim_item.kind] or "", vim_item.kind)
                  vim_item.abbr = vim_item.abbr:match "[^(]+"
                  vim_item.menu = string.format(" [%s]", entry.source.name)
                  return vim_item
               end,
            },
            window = {
               completion = cmp.config.window.bordered {
                  winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
               },
               completeopt = "menu,menuone,noinsert",
               documentation = cmp.config.window.bordered(),
            },
            sources = combined_sources,
            sorting = {
               comparators = {
                  cmp.config.compare.locality,
                  cmp.config.compare.scopes,
                  cmp.config.compare.recently_used,
                  cmp.config.compare.score,
                  require("cmp-under-comparator").under,
                  cmp.config.compare.kind,
               },
            },
         }
      end,
      config = function(_, opts)
         local cmp = require "cmp"
         cmp.setup(opts)

         cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(cmdline_mappings),
            sources = {
               { name = "nvim_lsp_document_symbol" },
               { name = "buffer" },
            },
         })

         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(cmdline_mappings),
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
               { name = "nvim_lsp", entry_filter = nvim_lsp_filter },
               { name = "nvim_lsp_signature_help" },
               { name = "buffer" },
            },
         })
      end,
      event = { "InsertCharPre", "CmdlineEnter" },
   },
}
