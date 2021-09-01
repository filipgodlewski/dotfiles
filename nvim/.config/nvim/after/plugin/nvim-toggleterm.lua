require("toggleterm").setup({
   shading_factor = "1",
   start_in_insert = false,
   float_opts = {
      border = "curved",
      width = function() return math.floor(vim.o.columns * 0.65) end,
      height = function() return math.floor(vim.o.lines * 0.5) end,
   },
})

local Terminal = require("toggleterm.terminal").Terminal

local configs = {
   repl = {
      python = {
         count = 2,
         cmd = "which bpython && bpython",
         direction = "float",
         dir = "git_dir",
         on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", ":ToggleTerm<CR>", {noremap = true, silent = true})
         end,
      },
   },
   ut = {
      python = {
         count = 3,
         cmd = "which pytest && pytest --pdb",
         direction = "float",
         dir = "git_dir",
         close_on_exit = true,
      },
   },
}

---@private
--- Get new terminal based on your lookup and filetype
---@param lookup string key to lookup in `configs` table
---@param ft string filetype to lookup in `configs` table
---@return Terminal[]
local function get_terminal(lookup, ft)
   local filetype = ft or vim.api.nvim_buf_get_option(0, "filetype")
   local config = configs[lookup][filetype]
   if config == nil then
      print("No " .. lookup .. " defined for the current filetype: " .. filetype)
      return
   end
   return Terminal:new(config)
end

--- Toggle REPL for the current buffer filetype
---@param ft string the filetype of the REPL
function Repl(ft)
   local term = get_terminal("repl", ft)
   if term ~= nil then
      term:toggle()
   end
end

--- Run unit tests for the current project.
---@param ft string the filetype appropriate for your project unit tests (defaults to buffer)
function UnitTests(ft)
   local term = get_terminal("ut", ft)
   if term ~= nil then
      if term:is_open() then -- it means that the debugger is running, so we want to close it first
         term:send("") -- debugger does not close immediately, so we have to check if it is closed
         vim.wait(5000, function() return not term:is_open() end, 10)
      end
      term:toggle()
   end
end

function Format_and_test(ft)
   vim.lsp.buf.formatting_sync()
   UnitTests(ft)
end

vim.cmd([[
augroup FormatAndTest
  autocmd!
  autocmd BufWrite * lua Format_and_test()
augroup END
]])
