-- -----------------------------------------------------------------------------
-- --------------------------------- hlchunk -----------------------------------
-- -----------------------------------------------------------------------------
return {
  "shellRaining/hlchunk.nvim",
  lazy = false,
  config = function()
    require("hlchunk").setup({
      chunk = {
        style = {
          { fg = "#90FDA9" },
        },
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}