local data = require("data")

return { -- Neovim Updater
  "rootiest/nvim-updater.nvim",
  lazy = false,
  opts = {},
  keys = function()
    -- Add Neovim Updater menu
    data.func.add_keymap(data.keys.group.nvimup)
    -- Add Neovim Updater keys
    return data.keys.nvimup
  end,
  dev = vim.g.rootiest_dev or false,
}
