vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
   callback = function()
      if not vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
         local builtin = require "telescope.builtin"
         local which_key = require "which-key"

         which_key.register({
            d = {
               function() require("definition_or_references").definition_or_references() end,
               "Definition or usages (LSP)",
            },
            s = { vim.lsp.buf.hover, "Show signature (LSP)" },
            y = { builtin.lsp_type_definitions, "Type definition (LSP)" },
         }, { prefix = "g", buffer = 0 })

         which_key.register({
            d = { function() require("trouble").toggle "document_diagnostics" end, "Open document diagnostics" },
            D = { function() require("trouble").toggle "workspace_diagnostics" end, "Open workspace diagnostics" },
            r = { vim.lsp.buf.rename, "Rename symbol (LSP)" },
         }, { prefix = "<leader>", buffer = 0 })
         which_key.register({
            R = { function() require("ssr").open() end, "Structural rename (LSP)" },
         }, { prefix = "<leader>", buffer = 0, mode = { "n", "v" } })
      end
   end,
})

local setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end

   local delete_breakpoints = function()
      require("dap").clear_breakpoints()
      require("user.helpers").deregister({ "d", "l", "t" }, { prefix = "<leader>g" })
   end

   require("dap").set_breakpoint(cond)
   require("which-key").register({
      d = { delete_breakpoints, "Delete breakpoints" },
      l = { function() require("telescope").extensions.dap.list_breakpoints() end, "List breakpoints" },
      t = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
   }, { prefix = "<leader>g" })
end

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("DebugKeymaps", { clear = true }),
   callback = function()
      local configs = { "python" }
      if vim.tbl_contains(configs, vim.api.nvim_buf_get_option(0, "filetype")) then
         require("which-key").register({
            g = {
               name = "Debug",
               b = { setup_breakpoint, "Put a breakpoint" },
               c = { function() require("dap").continue() end, "Start/Continue debugger" },
            },
            u = { require("neotest").summary.toggle, "Toggle Neotest" },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})

vim.api.nvim_create_autocmd("BufEnter", {
   group = vim.api.nvim_create_augroup("Laaaazy", { clear = true }),
   callback = function() vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" }) end,
})
