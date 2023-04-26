vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
   callback = function()
      if not vim.tbl_isempty(vim.lsp.get_active_clients { bufnr = 0 }) then
         local builtin = require "telescope.builtin"
         require("which-key").register({
            i = {
               name = "Inspect",
               d = { builtin.lsp_definitions, "Definition" },
               s = { vim.lsp.buf.hover, "Signature" },
               t = { builtin.lsp_type_definitions, "Type definition" },
               u = { builtin.lsp_references, "Usages" },
            },
            l = {
               name = "Lenses",
               d = { function() require("trouble").toggle "document_diagnostics" end, "Document" },
               n = { vim.diagnostic.goto_next, "Next" },
               p = { vim.diagnostic.goto_prev, "Previous" },
               w = { function() require("trouble").toggle "workspace_diagnostics" end, "Workspace" },
            },
            r = {
               name = "Replace",
               r = { vim.lsp.buf.rename, "Rename" },
               s = { require("ssr").open, "Structural" },
            },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})

local setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end

   local delete_breakpoints = function()
      require("dap").clear_breakpoints()
      require("user.helpers").deregister({ "d", "l", "t" }, { prefix = "<leader>b" })
   end

   require("dap").set_breakpoint(cond)
   require("which-key").register({
      name = "Breakpoint [ACTIVE]",
      d = { delete_breakpoints, "Deactivate" },
      l = { function() require("telescope").extensions.dap.list_breakpoints() end, "List" },
      t = { function() require("dap").toggle_breakpoint() end, "Toggle" },
   }, { prefix = "<leader>b" })
end

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("DebugKeymaps", { clear = true }),
   callback = function()
      local configs = { "python" }
      if vim.tbl_contains(configs, vim.api.nvim_buf_get_option(0, "filetype")) then
         require("which-key").register({
            b = { name = "Breakpoint", b = { setup_breakpoint, "Set" } },
            d = { name = "Debug", c = { function() require("dap").continue() end, "Continue" } },
            u = { require("neotest").summary.toggle, buffer = true, desc = "Neotest" },
         }, { prefix = "<leader>", buffer = 0 })
      end
   end,
})
