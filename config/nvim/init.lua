LAZY_PLUGIN_SPEC = {}

function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end


require "user.launch"
require "user.options"
require "user.keymaps"
require "user.autocmds"

spec "user.sexp"
-- this one first
spec "user.nvlime"
spec "user.devicons"
spec "user.treesitter"
spec "user.mason"
spec "user.schemastore"
spec "user.lspconfig"
spec "user.cmp"
spec "user.telescope"
spec "user.none-ls"
spec "user.illuminate"
spec "user.gitsigns"
spec "user.whichkey"
spec "user.nvimtree"
spec "user.vim-vinegar"
spec "user.comment"
spec "user.lualine"
spec "user.navic"
-- spec "user.breadcrumbs"
spec "user.harpoon"
-- spec "user.neotest"
spec "user.autopairs"
spec "user.neogit"
spec "user.alpha"
spec "user.project"
-- spec "user.session"
spec "user.indentline"
spec "user.toggleterm"
-- spec "user.copilot"
-- spec "user.extras.copilot"
spec "user.extras.cellular-automaton"
-- spec "user.nvim-dap"
spec "user.obsidian"
spec "user.pomodoro"

-- ones that I have personally vetted and understand:
spec "user.leap"
spec "user.trouble"
spec "user.marks"
<<<<<<< Updated upstream
require "user.lazy"
=======

spec "user.colorscheme"
spec "user.fennel"
require "config.lazy"
>>>>>>> Stashed changes
