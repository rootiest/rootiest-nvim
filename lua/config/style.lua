-- -----------------------------------------------------------------------------
-- ---------------------------------- Style ------------------------------------
-- -----------------------------------------------------------------------------

-- Get the kitty theme
if os.getenv("KITTY_THEME") then
  KITTY_THEME = os.getenv("KITTY_THEME")
end

-- Apply the colorscheme
vim.cmd.colorscheme(KITTY_THEME or "catppuccin-frappe")

-- Set GUI font
vim.opt.guifont = "Iosevka:#e-subpixelantialias:h12"
vim.g.have_nerd_font = true