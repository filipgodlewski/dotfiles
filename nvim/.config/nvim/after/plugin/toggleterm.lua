local function get_width() return math.floor(math.min(vim.o.columns, 120) * 0.9) end

require("toggleterm").setup {
   size = function(term)
      if term.direction == "horizontal" then
         return 20
      elseif term.direction == "vertical" then
         return get_width()
      end
   end,
   shade_terminals = false,
   start_in_insert = true,
   open_mapping = [[\\]],
   insert_mappings = false,
   autochdir = true,
   direction = get_width() > math.floor(120 * 9) and "vertical" or "float",
   float_opts = {
      border = "curved",
      width = get_width(),
      height = function() return math.floor(vim.o.lines * 0.75) end,
   },
}

local Terminal = require("toggleterm.terminal").Terminal

local configs = {
   repl = {
      python = {
         count = 2,
         cmd = "which bpython && bpython",
         direction = "float",
         dir = "git_dir",
         on_open = function(_) vim.cmd "startinsert!" end,
      },
   },
   ut = {
      python = {
         count = 4,
         cmd = "which pytest && pytest --pdb",
         direction = "float",
         dir = "git_dir",
         on_open = function(_) vim.cmd "startinsert!" end,
         close_on_exit = true,
      },
   },
}

---@private
--- Get new terminal based on your lookup and filetype
---@param lookup string key to lookup in `configs` table
---@param ft string filetype to lookup in `configs` table
---@param args array the array of strings that represent additional command line arguments
---@return Terminal[]
local function get_terminal(lookup, ft, args)
   local filetype = ft or vim.api.nvim_buf_get_option(0, "filetype")
   local config = configs[lookup][filetype]
   if args ~= nil then
      for _, arg in ipairs(args) do
         config.cmd = config.cmd .. " " .. arg
      end
   end
   if config == nil then
      print("No " .. lookup .. " defined for the current filetype: " .. filetype)
      return
   end
   return Terminal:new(config)
end

--- Toggle REPL for the current buffer filetype
---@param ft string the filetype of the REPL
---@param args array the array of strings that represent additional command line arguments
function Repl(ft, args)
   local term = get_terminal("repl", ft, args)
   if term ~= nil then term:toggle() end
end

--- Run unit tests for the current project.
---@param ft string the filetype appropriate for your project unit tests (defaults to buffer)
---@param args array the array of strings that represent additional command line arguments
function UnitTests(ft, args)
   local term = get_terminal("ut", ft, args)
   if term ~= nil then
      if term:is_open() then -- it means that the debugger is running, so we want to close it first
         term:send "" -- debugger does not close immediately, so we have to check if it is closed
         vim.wait(5000, function() return not term:is_open() end, 10)
      end
      term:toggle()
   end
end
