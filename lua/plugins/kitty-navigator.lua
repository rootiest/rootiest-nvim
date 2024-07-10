-- -----------------------------------------------------------------------------
-- ----------------------------- kitty-navigator -------------------------------
-- -----------------------------------------------------------------------------
return {
  "knubie/vim-kitty-navigator",
  cond = function() -- Using Kitty
    local term = os.getenv("TERM")
    return term and string.find(term, "kitty")
  end,
  keys = {
    { "<c-h>", "<cmd>KittyNavigateLeft<cr>", desc = "KittyNavigateLeft" },
    { "<c-j>", "<cmd>KittyNavigateDown<cr>", desc = "KittyNavigateDown" },
    { "<c-k>", "<cmd>KittyNavigateUp<cr>", desc = "KittyNavigateUp" },
    { "<c-l>", "<cmd>KittyNavigateRight<cr>", desc = "KittyNavigateRight" },
  },
}
