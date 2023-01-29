local fb_actions = require("telescope").extensions.file_browser.actions
local quickfix = require "user.quickfix"
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local actions_state = require "telescope.actions.state"

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

require("which-key").register({
   name = "Search",
   b = { builtin.buffers, "Buffers" },
   f = { function() builtin.find_files { hidden = true } end, "Files" },
   g = { builtin.live_grep, "Grep" },
   h = { builtin.help_tags, "Help" },
   l = { builtin.resume, "Last" },
   w = { telescope.extensions.workspaces.workspaces, "Workspaces" },
}, { prefix = "<leader>t" })

require("which-key").register({
   ["<space>"] = { function() builtin.find_files { hidden = true } end, "Files" },
}, { prefix = "<leader>" })
