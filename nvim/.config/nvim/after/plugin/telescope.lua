local fb_actions = require("telescope").extensions.file_browser.actions
local quickfix = require "user.quickfix"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local actions_state = require "telescope.actions.state"

local search_in_folders = {
   "~/personal",
   "~/dotfiles",
   "~/projects",
   "~/learning",
   "~/.local/share/nvim/site/pack/packer/start",
}

local exclude_patterns = {
   -- omitted folders
   "venv",
   "**/__*",
   -- folders specific to `learning`
   "*-workspace",
   "*.playground",
   "*-challenge",
   -- src folders
   "target", -- rust
   "src", -- python
   "lua", -- lua
}

local function add_to_workspaces()
   local entry = actions_state.get_selected_entry()
   if not entry then return end
   require("workspaces").add(entry.value)
end

telescope.setup {
   defaults = {
      prompt_prefix = "   ",
      selection_caret = "    ",
      multi_icon = " ",
      entry_prefix = "     ",
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
         "--trim",
      },
      file_ignore_patterns = {
         "dist",
         "target",
         "node_modules",
         "pack/plugins",
      },
      mappings = {
         i = { ["<C-Q>"] = { quickfix.setup_search, type = "action" } },
      },
   },
   extensions = {
      ["session-lens"] = {
         winblend = 0,
         prompt_title = "Switch Nvim Session",
         mappings = {
            i = { ["<C-d>"] = fb_actions.remove },
            n = { ["<C-d>"] = fb_actions.remove },
         },
      },
      ["ui-select"] = {
         require("telescope.themes").get_cursor {},
      },
      fzf = {
         override_generic_sorter = true,
         override_file_sorter = true,
         case_mode = "smart_case",
      },
      file_browser = {
         theme = "ivy",
         grouped = true,
         hidden = true,
         previewer = false,
         mappings = {
            i = { ["<M-w>"] = add_to_workspaces },
            n = { ["<M-w>"] = add_to_workspaces },
         },
      },
   },
   pickers = {
      buffers = {
         theme = "dropdown",
         mappings = {
            i = { ["<C-d>"] = "delete_buffer" },
            n = { ["<C-d>"] = "delete_buffer" },
         },
      },
      find_files = {
         file_ignore_patterns = {
            ".git",
            "venv",
            "**/__*",
            "target",
         },
      },
      spell_suggest = { theme = "cursor" },
   },
}

local extensions = {
   "ui-select",
   "fzf",
   "file_browser",
   "dap",
   "workspaces",
}

for _, extension in ipairs(extensions) do
   telescope.load_extension(extension)
end

local function append_excluded_patterns(args)
   for _, exclude_pattern in ipairs(exclude_patterns) do
      table.insert(args, { "-E", exclude_pattern })
   end
   return args
end

local function append_searched_in_folders(args)
   for _, folder in ipairs(search_in_folders) do
      table.insert(args, vim.fn.expand(folder))
   end
   return args
end

local function peek_folders(opts)
   local cwd = opts.cwd_to_path and opts.path or opts.cwd
   local async_oneshot_finder = require "telescope.finders.async_oneshot_finder"
   local entry_maker = opts.entry_maker { cwd = cwd }
   local args = { "-t", "d", "-a", "-g", ".git" }
   if opts.hidden then table.insert(args, "-H") end
   if opts.respect_gitignore == false then table.insert(args, "--no-ignore-vcs") end
   args = append_excluded_patterns(args)
   args = append_searched_in_folders(args)
   table.insert(args, { "-X", "dirname" })
   args = vim.tbl_flatten(args)
   return async_oneshot_finder {
      fn_command = function() return { command = "fd", args = args } end,
      entry_maker = entry_maker,
      results = { entry_maker(opts.cwd) },
      cwd = opts.cwd,
   }
end

require("which-key").register({
   name = "Search",
   b = { builtin.buffers, "Buffers" },
   f = { function() builtin.find_files { hidden = true } end, "Files" },
   g = { builtin.live_grep, "Grep" },
   h = { builtin.help_tags, "Help" },
   l = { builtin.resume, "Last" },
   w = { telescope.extensions.workspaces.workspaces, "Workspaces" },
   z = { telescope.extensions.file_browser.file_browser, "Browse" },
   Z = {
      function()
         telescope.extensions.file_browser.file_browser {
            cwd = "~",
            files = false,
            browse_folders = peek_folders,
            prompt_title = "Peek files",
         }
      end,
      "Peek",
   },
}, { prefix = "<leader>t" })
