-- -----------------------------------------------------------------------------
-- ------------------------------ kitty-runner ---------------------------------
-- -----------------------------------------------------------------------------
return {
  "jghauser/kitty-runner.nvim",
  cond = function() -- Using Kitty
    local term = os.getenv("TERM")
    return term and string.find(term, "kitty")
  end,
}