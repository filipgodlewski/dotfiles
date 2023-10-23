local helpers = require "user.helpers"

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
      }, { prefix = "<localLeader>C", buffer = 0 })
   end,
})

vim.api.nvim_create_autocmd("User", {
   pattern = "GitConflictResolved",
   callback = function()
      vim.notify(string.format("All conflicts in %q were resolved", vim.fn.expand "%:~"))
      helpers.deregister({ "0", "b", "l", "n", "p", "r" }, { prefix = "<localLeader>C", buffer = 0 })
      helpers.deregister({ "C" }, { prefix = "<localLeader>", buffer = 0 })
   end,
})
