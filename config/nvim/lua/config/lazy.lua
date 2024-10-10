local function ensure_installed(plugin, branch)
  local user, repo = string.match(plugin, "(.+)/(.+)")
  local repo_path = vim.fn.stdpath "data" .. "/lazy" .. repo
  if not (vim.uv or vim.loop).fs_stat(repo_path) then
    vim.notify("Installing " .. plugin .. " " .. branch)
    local repo_url = "https://github.com/" .. plugin .. ".git"
    local out = vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=" .. branch,
      repo_url,
      repo_path
    }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo ({
        { "Failed to clone" .. plugin .. ":\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  return repo_path
end

local lazypath = ensure_installed("folke/lazy.nvim", "stable")
-- vim.opt.rtp:prepend(lazypath)

-- hotpot alternative
local hotpot_path = ensure_installed("rktjmp/hotpot.nvim", "v0.14.6")
vim.opt.rtp:prepend({hotpot_path, lazypath})
vim.loader.enable()
require("hotpot")
-- include hotpot as a plugin, so it plays nice with lazy.nvim
table.insert(LAZY_PLUGIN_SPEC, "rktjmp/hotpot.nvim")

-- = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system {
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable",
--     lazypath,
--   }
-- end


require("lazy").setup {
  spec = LAZY_PLUGIN_SPEC,
  install = {
    colorscheme = { "darkplus", "default" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      paths = {
        vim.fn.stdpath("config") .. "/.compiled"
      }
    }
  }
}

