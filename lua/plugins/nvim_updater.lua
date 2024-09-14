return { -- Neovim Updater
  "rootiest/nvim-updater.nvim",
  lazy = false,
  opts = {},
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
    {
      "<Leader>quR",
      function()
        require("nvim_updater").update_neovim({ build_type = "Release" })
      end,
      desc = "Release Build Neovim",
    },
    {
      "<Leader>quC",
      function()
        require("nvim_updater").remove_source_dir()
      end,
      desc = "Clean Neovim Source",
    },
  },
  dev = vim.g.rootiest_dev or false,
}
