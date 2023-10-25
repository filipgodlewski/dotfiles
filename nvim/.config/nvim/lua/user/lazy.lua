local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   local repo = "https://github.com/folke/lazy.nvim"
   vim.fn.system { "git", "clone", "--filter=blob:none", "-b", "stable", repo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
   defaults = { lazy = true },
   install = { colorscheme = { "catppuccin-macchiato" } },
   checker = { enabled = true, notify = false },
   change_detection = { notify = false },
   rtp = {
      disabled_plugins = {
         "2html_plugin",
         "tohtml",
         "getscript",
         "getscriptPlugin",
         "gzip",
         "logipat",
         "netrw",
         "netrwPlugin",
         "netrwSettings",
         "netrwFileHandlers",
         "matchit",
         "tar",
         "tarPlugin",
         "rrhelper",
         "spellfile_plugin",
         "vimball",
         "vimballPlugin",
         "zip",
         "zipPlugin",
         "tutor",
         "rplugin",
         "syntax",
         "synmenu",
         "optwin",
         "compiler",
         "bugreport",
         "ftplugin",
      },
   },
})
