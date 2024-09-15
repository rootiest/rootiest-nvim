--- @module "plugins.dashboard.alpha"
--- This module defines the alpha plugin spec for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                          ALPHA                          │
--          ╰─────────────────────────────────────────────────────────╯
return { -- Alpha
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = require("data.func").check_global_var(
    "dashboard",
    "alpha",
    "alpha"
  ),
  opts = require("data.dash").alpha.opts,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    -- Setup the dashboard
    require("alpha").setup(dashboard.opts)

    -- Open Alpha when Vim is started with no file arguments
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        -- If auto-cursorline is installed, disable it
        if pcall(require, "auto-cursorline") then
          require("auto-cursorline").disable({ buffer = true })
        end
        dashboard.section.footer.val = "󰇥  Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms 󱐌"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
