-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  { "n", "x", "v" },
  "<leader>fCp",
  "<cmd>let @+ = expand('%')<cr><cmd>echo 'copied ' . expand('%')<cr>",
  { desc = "Copy relative file path" }
)

vim.keymap.set(
  { "n", "x", "v" },
  "<leader>fCP",
  "<cmd>let @+ = expand('%:p')<cr><cmd>echo 'copied ' . expand('%:p')<cr>",
  { desc = "Copy absolute file path" }
)
