local data = require("data")

return { -- Neovim Updater
  "rootiest/nvim-updater.nvim",
  opts = {
    verbose = false,
    check_for_updates = true,
    update_interval = (60 * 60) * 6, -- 6 hours
    default_keymaps = false,
  },
  keys = function()
    -- Add Neovim Updater menu
    data.func.add_keymap(data.keys.group.nvimup)
    -- Add Neovim Updater keys
    return data.keys.nvimup
  end,
  dev = vim.g.rootiest_dev or false,
}
