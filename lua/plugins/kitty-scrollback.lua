-- -----------------------------------------------------------------------------
-- ---------------------------- kitty-scrollback -------------------------------
-- -----------------------------------------------------------------------------
return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  version = "*",
  config = function() -- Using Kitty-Scrollback
    if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
      require("kitty-scrollback").setup()
    end
  end,
}

