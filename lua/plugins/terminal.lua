--          ╭─────────────────────────────────────────────────────────╮
--          │                        Terminals                        │
--          ╰─────────────────────────────────────────────────────────╯
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?.lua"

local data = require("data")

return {
  { -- Smart-Splits
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    build = data.types.smart_splits.build(),
  },
  { -- Image Renderer
    "3rd/image.nvim",
    ft = data.types.image,
    config = function()
      require("image").setup()
    end,
    cond = vim.g.useimage and not vim.g.neovide,
  },
  { -- ToggleTerm
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = data.keys.toggleterm,
    config = function()
      require("toggleterm").setup(data.types.toggleterm)
    end,
  },
  { -- Kitty-Runner
    "jghauser/kitty-runner.nvim",
    cond = data.func.is_kitty(),
  },
  { -- Kitty-Scrollback
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = data.cmd.kitty_scrollback,
    event = { "User KittyScrollbackLaunch" },
    version = "*",
    config = function() -- Using Kitty-Scrollback
      if data.func.is_kitty_scrollback() then
        require("kitty-scrollback").setup()
      end
    end,
    cond = data.func.is_kitty_scrollback(),
  },
  { -- Nekifoch
    "NeViRAIDE/nekifoch.nvim",
    lazy = true,
    cmd = data.cmd.nekifoch,
    opts = {
      kitty_conf_path = vim.env.HOME .. "/.kittyoverrides",
    },
    keys = data.keys.nekifoch,
    cond = data.func.is_kitty(),
  },
  { -- WezTerm
    "willothy/wezterm.nvim",
    config = true,
    cond = data.func.is_wezterm(),
  },
  { -- Tmux
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
    cond = data.func.is_tmux(),
  },
}
