--          ╭─────────────────────────────────────────────────────────╮
--          │                        DASH DATA                        │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

M.choices = {
  { -- Find File
    action = "lua LazyVim.pick()()",
    desc = " Find File",
    icon = " ",
    key = "f",
  },
  { -- New File
    action = "ene | startinsert",
    desc = " New File",
    icon = " ",
    key = "n",
  },
  { -- Open Recent Files
    action = 'lua LazyVim.pick("oldfiles")()',
    desc = " Recent Files",
    icon = " ",
    key = "r",
  },
  { -- Find Text
    action = 'lua LazyVim.pick("live_grep")()',
    desc = " Find Text",
    icon = " ",
    key = "g",
  },
  { -- LazyGit
    action = "LazyGit",
    desc = " LazyGit",
    icon = " ",
    key = "z",
  },
  { -- Config
    action = "lua LazyVim.pick.config_files()()",
    desc = " Config",
    icon = " ",
    key = "c",
  },
  { -- Restore Session
    action = 'lua require("persistence").load()',
    desc = " Restore Session",
    icon = " ",
    key = "s",
  },
  { -- Remote Session
    action = 'lua require("config.rootiest").load_remote()',
    desc = " Remote Session",
    icon = "󰢹 ",
    key = "S",
  },
  { -- Lazy
    action = "Lazy",
    desc = " Lazy",
    icon = "󰒲 ",
    key = "l",
  },
  { -- Quit
    action = function()
      vim.api.nvim_input("<cmd>qa<cr>")
    end,
    desc = " Quit",
    icon = " ",
    key = "q",
  },
}

return M
