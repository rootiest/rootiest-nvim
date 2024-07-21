-- -----------------------------------------------------------------------------
-- ----------------------------------- UI --------------------------------------
-- -----------------------------------------------------------------------------

return {
  { -- Edgy
    import = "lazyvim.plugins.extras.ui.edgy",
  },
  { -- Mini-animate
    import = "lazyvim.plugins.extras.ui.mini-animate",
  },
  { -- Transparent
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    config = true,
  },
  { -- Auto Dark Mode
    "f-person/auto-dark-mode.nvim",
    lazy = true,
    opts = {
      update_interval = 2000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme(
          STORED_THEME or KITTY_THEME or "catppuccin-frappe" or "tokyonight"
        )
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme(
          STORED_THEME or KITTY_THEME or "catppuccin-frappe" or "tokyonight"
        )
      end,
    },
    cond = function() -- Not Using SSH
      local ssh = os.getenv("SSH_TTY") or false
      return not ssh
    end,
  },
  { -- Hlchunk
    "shellRaining/hlchunk.nvim",
    event = "BufEnter",
    config = function()
      local cb = function()
        if vim.g.colors_name == "tokyonight" then
          return "#806d9c"
        elseif vim.g.colors_name:find("catppuccin") then
          local catpalette = require("catppuccin.palettes").get_palette()
          return catpalette.teal
        elseif vim.g.colors_name == "monochrome" or "github_dark" then
          return "#CCCCCC"
        elseif vim.g.colors_name == "gruvbox" then
          return "#a9b665"
        elseif vim.g.colors_name == "dracula" or "eldritch" then
          return "#50fa7b"
        elseif vim.g.colors_name == "onedark" or "nightfox" then
          return "#98C379"
        elseif vim.g.colors_name == "nord" then
          return "#81A1C1"
        elseif vim.g.colors_name == "kanagawa" then
          return "#73C8AD"
        elseif vim.g.colors_name == "everforest" then
          return "#8FBCBB"
        elseif vim.g.colors_name == "github_light" or "paper" then
          return "#3f3f5a"
        elseif vim.g.colors_name == "neofusion" then
          return "#420ADD"
        else
          return "#7581FF"
        end
      end
      local common_config = {
        chunk = {
          style = {
            { fg = cb },
          },
          enable = true,
        },
        indent = {
          enable = true,
          use_treesitter = true,
          chars = {
            "․․",
            "⁚⁚",
            "⁖⁖",
            "⁘⁘",
            "⁙⁙",
            "󱗿󱗿",
            "󱗽󱗽",
            "󱗼󱗼",
          },
        },
      }
      if vim.o.background == "dark" then
        common_config.indent.style = {
          { fg = "#434437" },
          { fg = "#2f4440" },
          { fg = "#433054" },
          { fg = "#284251" },
          { fg = "#3e4451" },
          { fg = "#565c64" },
          { fg = "#6b737f" },
          { fg = "#848a91" },
        }
      else
        common_config.indent.style = {
          { fg = "#d0b0b0" },
          { fg = "#b0b0d0" },
          { fg = "#b0d0b0" },
          { fg = "#a0a0a0" },
          { fg = "#c0c0c0" },
          { fg = "#e0e0e0" },
          { fg = "#f0f0f0" },
          { fg = "#ffffff" },
        }
      end
      require("hlchunk").setup(common_config)
    end,
  },
  { -- Alternate
    "ton/vim-alternate",
    event = "VeryLazy",
  },
}
