local map = LazyVim.safe_keymap_set

map("n", "<m-a>", "<cmd>norm! ggVG<cr>", { desc = "Select whole file" })
map("v", "<m-/>", "<cmd>norm! gcc<cr>", { desc = "Comment line" })
