local M = {"folke/tokyonight.nvim", priority = 1000, lazy = false}
M.config = function()
  require("tokyonight").setup({style = "moon"})
  return vim.cmd.colorscheme("tokyonight")
end
return M