require("which-key").setup {
   key_labels = {
      ["<space>"] = "␣",
      ["<cr>"] = "",
      ["<tab>"] = "",
      ["<M-Bslash>"] = [[<M-\>]],
      ["<leader>"] = "⌘",
   },
   layout = {
      height = { min = 1, max = 25 },
      width = { min = 5, max = 50 },
      align = "center",
   },
   icons = {
      separator = "ﰲ",
      group = " ",
   },
}

vim.keymap.set("n", "<esc>", ":silent LuaSnipUnlinkCurrent<cr>", { remap = true, desc = "Escape" })
