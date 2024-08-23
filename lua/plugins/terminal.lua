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

return {
  { -- Smart-Splits
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    build = "./kitty/install-kittens.bash",
  },
  { -- Image Renderer
    "3rd/image.nvim",
    ft = require("data.types").image,
    config = function()
      require("image").setup()
    end,
    cond = vim.g.useimage and not vim.g.neovide,
  },
  { -- ToggleTerm
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = require("data.keys").toggleterm,
    config = function()
      require("toggleterm").setup(require("data.types").toggleterm)
    end,
  },
  { -- Kitty-Runner
    "jghauser/kitty-runner.nvim",
    cond = require("data.func").is_kitty(),
  },
  { -- Kitty-Scrollback
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = require("data.cmd").kitty_scrollback,
    event = { "User KittyScrollbackLaunch" },
    version = "*",
    config = function() -- Using Kitty-Scrollback
      if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
        require("kitty-scrollback").setup()
      end
    end,
  },
  { -- Nekifoch
    "NeViRAIDE/nekifoch.nvim",
    lazy = true,
    cmd = require("data.cmd").nekifoch,
    opts = {
      kitty_conf_path = vim.env.HOME .. "/.kittyoverrides",
    },
    keys = require("data.keys").nekifoch,
    cond = require("data.func").is_kitty(),
  },
  { -- WezTerm
    "willothy/wezterm.nvim",
    config = true,
    cond = function() -- Using WezTerm
      local wterm = os.getenv("TERM_PROGRAM")
      return wterm and string.find(wterm, "WezTerm")
    end,
  },
  { -- Tmux
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
    cond = require("data.func").is_tmux(),
  },
}
