return { -- Neovim Updater
  "rootiest/nvim-updater.nvim",
  config = function()
    require("nvim_updater").setup({})
  end,
  cmd = {
    "UpdateNeovim",
  },
  keys = {
    {
      "<Leader>quU",
      ":UpdateNeovim<CR>",
      desc = "Update Neovim",
    },
    {
      "<Leader>quD",
      function()
        require("nvim_updater").update_neovim({ build_type = "Debug" })
      end,
      desc = "Debug Build Neovim",
    },
  },
  dev = vim.g.rootiest_dev or false,
}
