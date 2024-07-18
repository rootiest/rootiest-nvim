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
        local kitty_theme = os.getenv("KITTY_THEME")
        vim.cmd.colorscheme(kitty_theme or "catppuccin-frappe")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        local kitty_theme = os.getenv("KITTY_THEME")
        vim.cmd.colorscheme(kitty_theme or "catppuccin-latte")
      end,
    },
    cond = function() -- Not Using SSH
      local ssh = os.getenv("SSH_TTY") or false
      return not ssh
    end,
  },
}
