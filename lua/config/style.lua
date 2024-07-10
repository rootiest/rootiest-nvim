-- -----------------------------------------------------------------------------
-- ---------------------------------- Style ------------------------------------
-- -----------------------------------------------------------------------------

-- Set the palette
if os.getenv("CATPPUCCIN_PALETTE") then
  TMEMEPALETTE = require("catppuccin.palettes").get_palette(os.getenv("CATPPUCCIN_PALETTE"))
end

-- Apply the colorscheme
vim.cmd.colorscheme(kitty_theme or "catppuccin-frappe")

-- Set GUI font
vim.opt.guifont = "MonaspiceKr Nerd Font Mono:#e-subpixelantialias:h13"
vim.g.have_nerd_font = true

-- Set transparency
vim.cmd(":TransparentDisable")