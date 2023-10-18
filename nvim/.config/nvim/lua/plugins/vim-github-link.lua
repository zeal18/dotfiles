return {
  {
    "knsh14/vim-github-link",
    keys = {
      {
        "<leader>gCc",
        function()
          vim.cmd("GetCommitLink")
        end,
        desc = "Copy commit link",
      },
      {
        "<leader>gCb",
        function()
          vim.cmd("GetCurrentBranchLink")
        end,
        desc = "Copy current branch link",
      },
    },
  },
}
