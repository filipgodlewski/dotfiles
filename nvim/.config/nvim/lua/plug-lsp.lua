local lspconfig = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local capabilities = protocol.make_client_capabilities()

local function on_attach(client, bufnr)
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

local servers = {"pyright", "jsonls", "denols"}

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities
}
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      spacing = 4,
   },
   update_in_insert = false,
 }
)

require("lspsaga").init_lsp_saga()
require("trouble").setup {}
require("nvim-web-devicons").setup {}
