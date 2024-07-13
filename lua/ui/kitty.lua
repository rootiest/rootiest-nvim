return {
  {
    "MunsMan/kitty-navigator.nvim",
    build = {
      "cp navigate_kitty.py ~/.config/kitty",
      "cp pass_keys.py ~/.config/kitty",
    },
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
    "jghauser/kitty-runner.nvim",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  {
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
  },
}
