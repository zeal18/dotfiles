-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local project_config = vim.fn.getcwd() .. "/.nvim/"

if vim.fn.isdirectory(project_config) == 1 then
  vim.opt.runtimepath:append(project_config)
end

vim.lsp.enable("gopls")
