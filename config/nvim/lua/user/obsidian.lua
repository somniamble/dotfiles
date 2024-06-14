local M = {
  "epwalsh/obsidian.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
    },
    {
      "epwalsh/pomo.nvim"
    },
    {
      "nvim-telescope/telescope.nvim"
    }
  }
}

local mappings = {
  ["<leader>o"] = {
    name = "+obsidian",
    ["<space>"] = { "<cmd>ObsidianSearch<cr>", "Search" },
    f = { "<cmd>ObsidianQuickSwitch<cr>", "Find File" },
    d = { "<cmd>ObsidianToday<cr>", "Today's Note" },
    n = { "<cmd>ObsidianNew<cr>", "New Note" },
    g = {
      name = "+go",
      d = { "<cmd>ObsidianFollowLink<cr>", "Follow Link" },
      r = { "<cmd>ObsidianBacklinks<cr>", "Backlinks" }
    }
  }
}

function M.config()
  local wk = require("which-key")
  wk.register(mappings)
  require("obsidian").setup {
    workspaces = {
      {
        name = "commons",
        path = "~/Obsidian/commons"
      }
    },
    daily_notes = {
      folder = "Daily",
      date_format = "%Y-%m-%d",
      template = "Daily.md"
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2
    },
    wiki_link_func = function(opts)
      return require("obsidian.util").wiki_link_id_prefix(opts)
    end,

    picker = {
      name = "telescope.nvim",
    },

    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- a map for custom variables. The key should be the variable and the value should be a function
      substitutions = {}
    },

    follow_url_func = function(url)
      -- open the url in the browser
      vim.fn.jobstart({"xdg-open", url})
    end,

    callbacks = {
      -- never mind all this, didn't scope to buffer like I expected
      -- enter_note = function(client, note)
      --   -- set bindings in here, using buffer 0 to indicate the current buffer
      --   opts = {
      --     mode = "n",
      --     buffer = vim.fn.bufnr(),
      --     noremap = false -- expect to remap
      --   }
      --   wk.register({
      --     g = {
      --       d = {"<cmd>ObsidianFollowLink<cr>", "[OBSIDIAN] Follow Link", opts},
      --       r = {"<cmd>ObsidianBacklinks<cr>", "[OBSIDIAN] Backlinks", opts},
      --     },
      --     ["<leader>f<space>"] = {"<cmd>ObsidianSearch", "[OBSIDIAN] Search", opts},
      --     ["<leader>ff"] = {"<cmd>ObsidianQuickSwitch", "[OBSIDIAN] Find File", opts}
      --   })

      -- end
    },
    -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = true,  -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      ["-"] = { char = "😐", hl_group = "ObsidianDone" }
      -- Replace the above with this if you don't have a patched font:

      -- You can also add more custom ones...
    },

    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },
    --autostart = true,

    -- log = {
    --   level = "info",
    -- },
    -- pomo = {
    --   work_time = 25,
    --   short_break_time = 5,
    --   long_break_time = 15,
    --   cycles = 4,
    -- },
  }
end

return M
