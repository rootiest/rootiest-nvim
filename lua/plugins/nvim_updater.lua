--          ╭─────────────────────────────────────────────────────────╮
--          │                      Nvim-Updater                       │
--          ╰─────────────────────────────────────────────────────────╯

return { -- Neovim Updater
  'rootiest/nvim-updater.nvim',
  version = '*', -- Pin to GitHub releases
  lazy = false,
  opts = {
    build_type = 'Release',
    branch = 'master',
    verbose = false,
    check_for_updates = true,
    update_interval = (60 * 60) * 6, -- 6 hours
    notify_updates = false,
    default_keymaps = false,
  },
  keys = function()
    -- Load Neovim Updater Debugging Functions
    require('config.nvim_updater') -- Debugging Functions

    -- Add Neovim Updater menu
    require('data.func').add_keymap(require('data.keys').group.nvimup)
    -- Add Neovim Updater keys
    return require('data.keys').nvimup
  end,
  dev = vim.g.rootiest_dev or false,
}
