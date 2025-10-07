return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts.previewers.builtin = vim.tbl_deep_extend("force", opts.previewers.builtin or {}, {
        snacks_image = { enabled = false },
      })
      opts.files = vim.tbl_deep_extend("force", opts.files or {}, {
        line_query = true,
      })
    end,
  },
}
