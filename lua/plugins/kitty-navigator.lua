-- -----------------------------------------------------------------------------
-- ----------------------------- kitty-navigator -------------------------------
-- -----------------------------------------------------------------------------
-- return {
--   "knubie/vim-kitty-navigator",
--   build = {
--     "cp ./*.py ~/.config/kitty/",
--   },
--   cond = function() -- Using Kitty
--     local term = os.getenv("TERM") or ""
--     local kit = string.find(term, "kitty")
--     return kit ~= nil
--   end,
-- }

return {
  "MunsMan/kitty-navigator.nvim",
  build = {
    "cp navigate_kitty.py ~/.config/kitty",
    "cp pass_keys.py ~/.config/kitty",
  },
  cond = function() -- Using Kitty
    local term = os.getenv("TERM") or ""
    local kit = string.find(term, "kitty")
    return kit ~= nil
  end,
}
