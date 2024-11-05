---@module "plugins.mini"
--- This module defines the mini plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          Mini                           │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  { -- mini.animate
    import = "lazyvim.plugins.extras.ui.mini-animate",
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
  },
  { -- Mini.Indentscope
    import = "lazyvim.plugins.extras.ui.mini-indentscope",
  },
  { -- Mini Indentscope
    "echasnovski/mini.indentscope",
    opts = data.types.miniindentscope.opts,
    init = data.types.miniindentscope.init,
  },
  { -- mini.align
    "echasnovski/mini.align",
    event = "InsertEnter",
    config = function()
      require("mini.align").setup()
    end,
  },
  { -- mini.splitjoin
    "echasnovski/mini.splitjoin",
    event = "InsertEnter",
    opts = {
      mappings = data.keys.splitjoin,
    },
  },
  { -- mini.surround
    "echasnovski/mini.surround",
    opts = {},
  },
  { -- mini.files
    "echasnovski/mini.files",
    opts = data.types.minifiles.opts,
    keys = data.keys.minifiles,
    config = data.types.minifiles.config,
  },
  { -- mini.icons
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
