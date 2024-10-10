local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}


function M.config()
  local servers = {
    "lua_ls",
    "yamlls",
    "helm_ls",
    "cssls",
    "html",
    "ts_ls",
    "pyright",
    "bashls",
    "jsonls",
    "omnisharp",
    "marksman",
    "gopls",
    "rust_analyzer"
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
