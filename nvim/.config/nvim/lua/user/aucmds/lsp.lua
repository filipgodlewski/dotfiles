vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("LspLoad", { clear = true }),
   callback = function()
      if not vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
         local which_key = require "which-key"

         which_key.register({
            d = { function() require("trouble").toggle "lsp_references" end, "Definition or usages (LSP)" },
            s = { vim.lsp.buf.hover, "Show signature (LSP)" },
            y = { function() require("trouble").toggle "lsp_type_definitions" end, "Type definition (LSP)" },
         }, { prefix = "g", buffer = 0 })

         which_key.register({
            d = { function() require("trouble").toggle "document_diagnostics" end, "Open document diagnostics (LSP)" },
            D = { function() require("trouble").toggle "workspace_diagnostics" end, "Open workspace diagnostics (LSP)" },
            r = { vim.lsp.buf.rename, "Rename symbol (LSP)" },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})
