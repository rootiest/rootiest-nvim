-- -----------------------------------------------------------------------------
-- -------------------------------- neo-tree -----------------------------------
-- -----------------------------------------------------------------------------
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      source_selector = {
        winbar = true,
        statusline = false,
      },
    })
  end,
}