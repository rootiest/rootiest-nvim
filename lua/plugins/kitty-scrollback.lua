-- -----------------------------------------------------------------------------
-- ---------------------------- kitty-scrollback -------------------------------
-- -----------------------------------------------------------------------------
return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
  config = function()
    if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
      require("kitty-scrollback").setup()
    end
  end,
}