local simple_compiler = function()
   Term = require("toggleterm.terminal").Terminal
   local full_file_path = vim.fn.expand "%"
   local file_name = vim.fn.expand "%:r"
   vim.cmd "w"
   local new_term = Term:new {
      cmd = string.format("gcc %s -o %s && ./%s", full_file_path, file_name, file_name),
      close_on_exit = false,
      on_exit = function() os.remove(file_name) end,
   }
   new_term:toggle()
end

require("which-key").register({
   name = "Exclusive to C",
   r = { simple_compiler, "Compile and Run (Simple)" },
}, { prefix = "<localLeader><localLeader>", buffer = 0 })
