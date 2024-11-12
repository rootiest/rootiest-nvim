---@module "plugins.terminal"
--- This module defines the terminal plugins spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Terminals                        │
--          ╰─────────────────────────────────────────────────────────╯

return {
  { -- Smart-Splits
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    build = require('data.types').smart_splits.build(),
  },
  { -- Image Renderer
    '3rd/image.nvim',
    ft = require('data.types').image,
    config = function()
      require('image').setup({
        backend = 'kitty', -- Kitty will provide the best experience, but you need a compatible terminal
        processor = 'magick_cli',
        kitty_method = 'normal',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'norg' },
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
          'cmp_menu',
          'cmp_docs',
          'neotree',
          'neominimap',
          'minimap',
          '',
        },
        hijack_file_patterns = {
          '*.png',
          '*.jpg',
          '*.jpeg',
          '*.gif',
          '*.webp',
          '*.avif',
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
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    keys = require('data.keys').toggleterm,
    config = function()
      require('toggleterm').setup(require('data.types').toggleterm)
    end,
  },
  { -- Kitty-Runner
    'jghauser/kitty-runner.nvim',
    cond = require('data.func').is_kitty(),
  },
  { -- Kitty-Scrollback
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = require('data.cmd').kitty_scrollback,
    event = { 'User KittyScrollbackLaunch' },
    version = '*',
    config = function() -- Using Kitty-Scrollback
      if require('data.func').is_kitty_scrollback() then
        require('kitty-scrollback').setup()
      end
    end,
    cond = require('data.func').is_kitty_scrollback(),
  },
  { -- Nekifoch
    'NeViRAIDE/nekifoch.nvim',
    lazy = true,
    cmd = require('data.cmd').nekifoch,
    opts = {
      kitty_conf_path = vim.env.HOME .. '/.kittyoverrides',
    },
    keys = require('data.keys').nekifoch,
    cond = require('data.func').is_kitty(),
  },
  { -- WezTerm
    'willothy/wezterm.nvim',
    config = true,
    cond = require('data.func').is_wezterm(),
  },
  { -- Tmux
    'aserowy/tmux.nvim',
    config = function()
      return require('tmux').setup()
    end,
    cond = require('data.func').is_tmux(),
  },
}
