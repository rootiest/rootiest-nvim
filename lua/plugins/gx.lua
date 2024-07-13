-- -----------------------------------------------------------------------------
-- ----------------------------------- gx --------------------------------------
-- -----------------------------------------------------------------------------
return {
  "chrishrb/gx.nvim",
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
}
