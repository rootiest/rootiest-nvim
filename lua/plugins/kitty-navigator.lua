-- -----------------------------------------------------------------------------
-- ----------------------------- kitty-navigator -------------------------------
-- -----------------------------------------------------------------------------
return {
  "knubie/vim-kitty-navigator",
  cond = function() -- Using Kitty
    local term = os.getenv("TERM")
    return term and string.find(term, "kitty")
  end,
}