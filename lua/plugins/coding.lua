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
    "shellRaining/hlchunk.nvim",
    config = function()
      local cb = function()
        if vim.g.colors_name == "tokyonight" then
          return "#806d9c"
        elseif vim.g.colors_name:find("catppuccin") then
          local catpalette = require("catppuccin.palettes").get_palette()
          return catpalette.rosewater
        else
          return "#90FDA9"
        end
      end
      require("hlchunk").setup({
        chunk = {
          style = {
            { fg = cb },
          },
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    "ton/vim-alternate",
    event = "VeryLazy",
  },
}
