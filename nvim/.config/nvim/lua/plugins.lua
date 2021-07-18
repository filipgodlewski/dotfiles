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

require'lspconfig'.sumneko_lua.setup {}

require("lspsaga").init_lsp_saga()

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
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require("colorizer").setup()

require("gitsigns").setup()

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
   context_commentstring = {
      enable = true,
      config = {
         lua = "-- %s",
      }
   }
}

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
