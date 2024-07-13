-- -----------------------------------------------------------------------------
-- ------------------------------ kitty-runner ---------------------------------
-- -----------------------------------------------------------------------------
return {
  "jghauser/kitty-runner.nvim",
  cond = function() -- Using Kitty
    local term = os.getenv("TERM") or ""
    local kit = string.find(term, "kitty")
    return kit ~= nil
  end,
}
