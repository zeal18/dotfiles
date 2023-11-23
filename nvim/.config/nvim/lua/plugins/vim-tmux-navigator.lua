return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      {
        "<C-h>",
        "<cmd> TmuxNavigateLeft<CR>",
        desc = "Navigate to the left split",
      },
      {
        "<C-j>",
        "<cmd> TmuxNavigateDown<CR>",
        desc = "Navigate to the bottom split",
      },
      {
        "<C-k>",
        "<cmd> TmuxNavigateUp<CR>",
        desc = "Navigate to the top split",
      },
      {
        "<C-l>",
        "<cmd> TmuxNavigateRight<CR>",
        desc = "Navigate to the right split",
      },
    },
  },
}
