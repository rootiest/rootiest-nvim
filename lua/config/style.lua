-- -----------------------------------------------------------------------------
-- ---------------------------------- Style ------------------------------------
-- -----------------------------------------------------------------------------

-- Set the palette
if os.getenv("CATPPUCCIN_PALETTE") then
  TMEMEPALETTE =
    require("catppuccin.palettes").get_palette(os.getenv("CATPPUCCIN_PALETTE"))
end

if os.getenv("KITTY_THEME") then
  KITTY_THEME = os.getenv("KITTY_THEME")
end

-- Apply the colorscheme
vim.cmd.colorscheme(KITTY_THEME or "catppuccin-frappe")

-- Set GUI font
--vim.opt.guifont = "MonaspiceKr Nerd Font Mono:#e-subpixelantialias:h13"
vim.opt.guifont = "Iosevka:#e-subpixelantialias:h13"
vim.g.have_nerd_font = true

-- Set transparency
vim.cmd(":TransparentDisable")
