-- -----------------------------------------------------------------------------
-- ---------------------------------- USER -------------------------------------
-- -----------------------------------------------------------------------------
-- ---------------------------------- STYLE ------------------------------------
----------- Apply the colorscheme -----------
--  1. Restore last colorscheme if it exists
--  2. Use kitty theme if it exists
--  3. Fallback to Catppuccin Frappe
--  4. Fallback to Tokyonight
vim.cmd.colorscheme(
  STORED_THEME or KITTY_THEME or "catppuccin-frappe" or "tokyonight"
)
