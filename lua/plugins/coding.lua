-- -----------------------------------------------------------------------------
-- --------------------------------- CODING ------------------------------------
-- -----------------------------------------------------------------------------

return {
  { import = "lazyvim.plugins.extras.coding.codeium" },
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "vim-scripts/AnsiEsc.vim",
    lazy = true,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
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
  },
}
