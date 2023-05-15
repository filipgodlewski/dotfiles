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

local function completer(sources) require("cmp").complete { config = { sources = sources } } end

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

         local mapping = cmp.mapping.preset.insert {
            ["<C-s>"] = cmp.mapping(function(_)
               cmp.close()
               completer(in_import_scope() and default_sources)
            end, { "i", "s" }),
            ["<C-l>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-n>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_next_item()
               elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
               elseif not matches_before_cursor(nil, "%s") then
                  cmp.complete()
               else
                  fallback()
               end
            end, { "i", "s" }),
            ["<C-p>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
               else
                  fallback()
               end
            end, { "i", "s" }),
            ["<C-t>"] = cmp.mapping(function(fallback)
               if require("luasnip").choice_active() then
                  require("luasnip").change_choice(1)
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
                  return vim_item
               end,
            },
            window = {
               completion = cmp.config.window.bordered {
                  winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
               },
               documentation = cmp.config.window.bordered(),
            },
            sources = default_sources,
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
      end,
      event = { "InsertCharPre", "CmdlineEnter" },
   },
}
