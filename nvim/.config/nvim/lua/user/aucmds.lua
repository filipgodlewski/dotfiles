local helpers = require "user.helpers"

vim.api.nvim_create_autocmd("FileType", {
   pattern = "qf",
   callback = function() vim.opt_local.buflisted = false end,
})

-- Taken from jghauser/mkdir.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
   group = vim.api.nvim_create_augroup("MkdirP", { clear = true }),
   callback = function()
      local dir = vim.fn.expand "<afile>:p:h"
      if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
   end,
})

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

         which_key.register({
            I = { function() require("lsp_lines").toggle() end, "Toggle Diagnostic Lines (LSP)" },
            R = { function() require("ssr").open() end, "Structural rename (LSP)" },
         }, { prefix = "<leader>", buffer = 0, mode = { "n", "v" } })
      end
   end,
})

local setup_breakpoint = function()
   local ok, cond = pcall(vim.fn.input, "Condition: ")
   if ok == false then return end

   local delete_breakpoints = function()
      helpers.deregister({ "d", "l", "t" }, { prefix = "<localLeader>", buffer = 0 })
      require("dap").clear_breakpoints()
   end

   require("dap").set_breakpoint(cond)
   require("which-key").register({
      d = { delete_breakpoints, "Delete breakpoints" },
      l = { function() require("telescope").extensions.dap.list_breakpoints() end, "List breakpoints" },
      t = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
   }, { prefix = "<localLeader>", buffer = 0 })
end

local dap_test_fts = { "python" }

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("DebugKeymapsIn", { clear = true }),
   callback = function()
      if vim.tbl_contains(dap_test_fts, vim.api.nvim_buf_get_option(0, "filetype")) then
         require("which-key").register({
            u = { require("neotest").summary.toggle, "Toggle Neotest" },
         }, { prefix = "<leader>" })

         require("which-key").register({
            b = { setup_breakpoint, "Put a breakpoint" },
            c = { function() require("dap").continue() end, "Start/Continue debugger" },
         }, { prefix = "<localLeader>" })
      end
   end,
})

vim.api.nvim_create_autocmd({ "BufFilePost", "BufEnter", "BufWinEnter", "LspAttach" }, {
   group = vim.api.nvim_create_augroup("DebugKeymapsOut", { clear = true }),
   callback = function()
      if not vim.tbl_contains(dap_test_fts, vim.api.nvim_buf_get_option(0, "filetype")) then
         helpers.deregister({ "u" }, { prefix = "<leader>" })
         helpers.deregister({ "b", "c" }, { prefix = "<localLeader>" })
      end
   end,
})

vim.api.nvim_create_autocmd("User", {
   pattern = "GitConflictDetected",
   callback = function()
      vim.defer_fn(function() vim.notify(string.format("Conflicts detected in %q", vim.fn.expand "%:~")) end, 500)
      require("which-key").register({
         ["0"] = { "<Plug>(git-conflict-none)", "Accept none" },
         b = { "<Plug>(git-conflict-both)", "Accept both changes" },
         l = { "<Plug>(git-conflict-ours)", "Accept local change" },
         n = { "<Plug>(git-conflict-next-conflict)", "Go to next conflict" },
         p = { "<Plug>(git-conflict-prev-conflict)", "Go to previous conflict" },
         r = { "<Plug>(git-conflict-theirs)", "Accept remote change" },
      }, { prefix = "<localLeader>", buffer = 0 })
   end,
})

vim.api.nvim_create_autocmd("User", {
   pattern = "GitConflictResolved",
   callback = function()
      vim.notify(string.format("All conflicts in %q were resolved", vim.fn.expand "%:~"))
      helpers.deregister({ "0", "b", "l", "n", "p", "r" }, { prefix = "<localLeader>", buffer = 0 })
   end,
})
