(local M {1 :folke/tokyonight.nvim :lazy false :priority 1000})

(fn M.config []
  ((. (require :tokyonight) :setup) {:style :moon})
  (vim.cmd.colorscheme :tokyonight))
M	
