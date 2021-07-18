" LSPCONFIG
lua << EOF
require("lspconfig").jsonls.setup {
   commands = {
      Format = {
         function()
           vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
         end
      },
   },
}

require'lspconfig'.pylsp.setup {
   on_attach = require("completion").on_attach,
}

require'lspconfig'.denols.setup {}
EOF

" LSPSAGA
lua << EOF
-- require("lspsaga").init_lsp_saga()
EOF

" WHICH-KEY
lua << EOF
require("which-key").setup {
   operators = {
      ["<leader>ij"] = "Insert",
      ["<leader>ik"] = "Insert",
   },
   key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
   }
}
EOF

" COLORIZER
lua << EOF
require("colorizer").setup()
EOF

" GITSIGNS
lua << EOF
require("gitsigns").setup()
EOF

" TREESITTER
lua << EOF
require("nvim-treesitter.configs").setup {
   highlight = {
      enable = true,
      custom_captures = {
         ["type.builtin.error"] = "TSTypeBuiltinError",
         ["type.builtin.warning"] = "TSTypeBuiltinWarning",
         ["type.operator.not"] = "TSTypeOperatorNot",
         ["text.ref"] = "TSRef",
      },
   },
}
EOF

" TELESCOPE
lua << EOF
require("telescope").setup {
   pickers = {
      live_grep = {
         hidden = true,
      },
      find_files = {
         hidden = true,
      },
      buffers = {
         theme = "dropdown",
         previewer = false,
         mappings = {
            i = {
               ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {
               ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
         },
      },
      
   },
}
EOF

" AUTOPAIRS
lua << EOF
require("nvim-autopairs").setup()
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
EOF
