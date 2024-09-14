return { -- Neovim Updater
  "rootiest/nvim-updater.nvim",
  lazy = false,
  config = function()
    require("nvim_updater").setup({
      source_dir = vim.fn.expand("~/.local/src/neovim"),
      build_type = "RelWithDebInfo",
      branch = "master",
    })
  end,
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
