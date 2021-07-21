local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local lsp_on_attach = function(client, bufnr)
   if client.resolved_capabilities.document_formatting then
     vim.api.nvim_command [[augroup Format]]
     vim.api.nvim_command [[autocmd! * <buffer>]]
     vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
     vim.api.nvim_command [[augroup END]]
   end

   protocol.CompletionItemKind = {
     '', -- Text
     '', -- Method
     '', -- Function
     '', -- Constructor
     '', -- Field
     '', -- Variable
     '', -- Class
     'ﰮ', -- Interface
     '', -- Module
     '', -- Property
     '', -- Unit
     '', -- Value
     '', -- Enum
     '', -- Keyword
     '﬌', -- Snippet
     '', -- Color
     '', -- File
     '', -- Reference
     '', -- Folder
     '', -- EnumMember
     '', -- Constant
     '', -- Struct
     '', -- Event
     'ﬦ', -- Operator
     '', -- TypeParameter
   }
end

nvim_lsp.jsonls.setup {
   commands = {
      Format = {
         function()
           vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
         end
      },
   },
}

nvim_lsp.pylsp.setup {on_attach = lsp_on_attach}
nvim_lsp.denols.setup {}

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

nvim_lsp.sumneko_lua.setup {
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

require("lspsaga").init_lsp_saga()
require("lsp_signature").setup {}
require("lsp_signature").on_attach()
