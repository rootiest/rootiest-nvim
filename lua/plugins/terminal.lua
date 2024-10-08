---@module "plugins.terminal"
--- This module defines the terminal plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Terminals                        │
--          ╰─────────────────────────────────────────────────────────╯
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
      require("image").setup({
        backend = "kitty", -- Kitty will provide the best experience, but you need a compatible terminal
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = 200, -- tweak to preference
        max_height = 40, -- ^
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = {
          "cmp_menu",
          "cmp_docs",
          "neotree",
          "neominimap",
          "minimap",
          "",
        },
        hijack_file_patterns = {
          "*.png",
          "*.jpg",
          "*.jpeg",
          "*.gif",
          "*.webp",
          "*.avif",
        }, -- render image files as images when opened
      })
    end,
    cond = function()
      -- Disable image rendering in Neovide
      -- or when vim.g.useimage = false
      if vim.g.useimage == false then
        return false
      end
      return not vim.g.neovide
    end,
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
