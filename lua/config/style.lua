-- -----------------------------------------------------------------------------
-- ---------------------------------- Style ------------------------------------
-- -----------------------------------------------------------------------------

-- Restore Colorscheme
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.colorscheme") == 1 then
  -- Load the stored colorscheme
  STORED_THEME = vim.fn.readfile(vim.fn.stdpath("config") .. "/.colorscheme")[1]
else
  -- Get the kitty theme
  if os.getenv("KITTY_THEME") then
    KITTY_THEME = os.getenv("KITTY_THEME")
  end
end

-- Apply the colorscheme
vim.cmd.colorscheme(STORED_THEME or KITTY_THEME or "catppuccin-frappe")

-- Set GUI font
vim.opt.guifont = "Iosevka:#e-subpixelantialias:h12"
vim.g.have_nerd_font = true
