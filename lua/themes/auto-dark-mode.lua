-- -----------------------------------------------------------------------------
-- ----------------------------- auto-dark-mode --------------------------------
-- -----------------------------------------------------------------------------
return {
  "f-person/auto-dark-mode.nvim",
  lazy = true,
  opts = {
    update_interval = 1000,
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
  cond = function() -- Not Using SSH or root
    local ssh = os.getenv("SSH_TTY")
    local user = os.getenv("USER")
    local root = string.find(user, "root")
    return not ssh and not root
  end,
}