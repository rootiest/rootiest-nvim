-- -----------------------------------------------------------------------------
-- ---------------------------------- Style ------------------------------------
-- -----------------------------------------------------------------------------
-- Apply the default colorscheme
if os.getenv("KITTY_THEME") then
  local kitty_theme = os.getenv("KITTY_THEME")
  -- Set the colorscheme palette
  if kitty_theme:find("catppuccin") then
    THEMEPALETTE = require("catppuccin.palettes").get_palette(kitty_theme:sub(12))
  else
    if vim.o.background == "dark" then
      THEMEPALETTE = require("catppuccin.palettes").get_palette("mocha")
    else
      THEMEPALETTE = require("catppuccin.palettes").get_palette("latte")
    end
  end
else
  if vim.o.background == "dark" then
    THEMEPALETTE = require("catppuccin.palettes").get_palette("mocha")
  else
    THEMEPALETTE = require("catppuccin.palettes").get_palette("latte")
  end
end
vim.cmd.colorscheme(kitty_theme or "catppuccin-frappe")

-- Set GUI font
vim.opt.guifont = "MonaspiceKr Nerd Font Mono:#e-subpixelantialias:h13"
vim.g.have_nerd_font = true