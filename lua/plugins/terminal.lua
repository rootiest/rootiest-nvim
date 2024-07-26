-- -----------------------------------------------------------------------------
-- -------------------------------- TERMINALS ----------------------------------
-- -----------------------------------------------------------------------------

package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?.lua"

return {
  { -- ToggleTerm
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        autochdir = true,
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 3,
          title_pos = "left",
        },
        winbar = {
          enabled = true,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end,
        },
      })
    end,
  },
  { -- Kitty-Navigator
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
  { -- Kitty-Runner
    "jghauser/kitty-runner.nvim",
    cond = function() -- Using Kitty
      local term = os.getenv("TERM") or ""
      local kit = string.find(term, "kitty")
      return kit ~= nil
    end,
  },
  { -- Kitty-Scrollback
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
  { -- Image Renderer
    "3rd/image.nvim",
    config = function()
      require("image").setup()
    end,
    cond = vim.g.useimage and not vim.g.neovide,
  },
  { -- WezTerm
    "willothy/wezterm.nvim",
    config = true,
    cond = function() -- Using WezTerm
      local wterm = os.getenv("TERM_PROGRAM")
      return wterm and string.find(wterm, "WezTerm")
    end,
  },
  { -- Tmux
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
    cond = function() -- Using Tmux
      local tterm = os.getenv("TERM")
      if tterm and string.find(tterm, "screen") then
        if os.getenv("TMUX") then
          return true
        end
      else
        if tterm and string.find(tterm, "tmux") then
          return true
        end
      end
    end,
  },
  { -- Navigator (wezterm/tmux)
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
    end,
    cond = function() -- Using Tmux or WezTerm
      local tterm = os.getenv("TERM")
      if tterm and string.find(tterm, "screen") then
        if os.getenv("TMUX") then
          return true
        end
      else
        if tterm and string.find(tterm, "tmux") then
          return true
        end
        local wterm = os.getenv("TERM_PROGRAM")
        return wterm and string.find(wterm, "WezTerm")
      end
    end,
  },
}
