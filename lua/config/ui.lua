-- -----------------------------------------------------------------------------
-- ----------------------------------- UI --------------------------------------
-- -----------------------------------------------------------------------------

return {
  { import = "lazyvim.plugins.extras.ui.edgy" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
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
}
