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
    event = "BufEnter",
    config = function()
      local cb = function()
        if vim.g.colors_name == "tokyonight" then
          return "#806d9c"
        elseif vim.g.colors_name:find("catppuccin") then
          local catpalette = require("catppuccin.palettes").get_palette()
          return catpalette.green
        elseif vim.g.colors_name == "monochrome" then
          return "#CCCCCC"
        elseif vim.g.colors_name == "gruvbox" then
          return "#a9b665"
        elseif vim.g.colors_name == "dracula" then
          return "#50fa7b"
        elseif vim.g.colors_name == "onedark" then
          return "#98C379"
        elseif vim.g.colors_name == "nightfox" then
          return "#98C379"
        elseif vim.g.colors_name == "nord" then
          return "#81A1C1"
        elseif vim.g.colors_name == "kanagawa" then
          return "#73C8AD"
        elseif vim.g.colors_name == "everforest" then
          return "#8FBCBB"
        elseif vim.g.colors_name == "github_dark" then
          return "#FFFFFF"
        elseif vim.g.colors_name == "github_light" then
          return "#3f3f3f"
        elseif vim.g.colors_name == "neofusion" then
          return "#420ADD"
        else
          return "#7581FF"
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
          enable = function()
            if vim.g.colors_name == "monochrome" then
              return false
            else
              return true
            end
          end,
        },
      })
    end,
  },
  {
    "ton/vim-alternate",
    event = "VeryLazy",
  },
}
