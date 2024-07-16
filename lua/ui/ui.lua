return {
  { import = "lazyvim.plugins.extras.ui.edgy" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  {
    "xiyaowong/transparent.nvim",
    config = true,
  },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        type = "default",
        cursor = "",
        texthl = "SmoothCursor",
        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "", texthl = nil, linehl = nil },
          body = {},
          tail = { false }, -- false to disable fancy tail
        },
        matrix = { -- Loaded when 'type' is set to "matrix"
          head = {
            cursor = require("smoothcursor.matrix_chars"),
            texthl = {
              "SmoothCursor",
            },
            linehl = nil, -- No line highlight for the head
          },
          body = {
            length = 6, -- Specifies the length of the cursor body
            cursor = require("smoothcursor.matrix_chars"),
            texthl = {
              "SmoothCursorGreen",
            },
          },
          tail = {
            cursor = nil,
            texthl = {
              "SmoothCursor",
            },
          },
          unstop = false,
        },
        autostart = true, -- Automatically start SmoothCursor
        always_redraw = true, -- Redraw the screen on each update
        flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
        speed = 25, -- Max speed is 100 to stick with your current position
        intervals = 35, -- Update intervals in milliseconds
        priority = 10, -- Set marker priority
        timeout = 3000, -- Timeout for animations in milliseconds
        threshold = 3, -- Animate only if cursor moves more than this many lines
        max_threshold = 2000, -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
        disable_float_win = false, -- Disable in floating windows
        enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
        disabled_filetypes = nil, -- Disable for these file types
        show_last_positions = nil,
      })
      -- Define cursor color/icon based on mode
      local autocmd = vim.api.nvim_create_autocmd
      autocmd({ "ModeChanged", "BufEnter" }, {
        callback = function()
          local current_mode = vim.fn.mode()
          if current_mode == "n" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa8f3" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "v" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#d298eb" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "V" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#d298eb" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "�" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "i" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#9bd482" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          end
        end,
      })
      -- Define last cursor position icon
      vim.fn.sign_define("smoothcursor_n", { text = "" })
      vim.fn.sign_define("smoothcursor_v", { text = " " })
      vim.fn.sign_define("smoothcursor_V", { text = "" })
      vim.fn.sign_define("smoothcursor_i", { text = "" })
      vim.fn.sign_define("smoothcursor_�", { text = "" })
      vim.fn.sign_define("smoothcursor_R", { text = "󰊄" })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = false,
    lazy = false,
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
  {
    "f-person/auto-dark-mode.nvim",
    lazy = true,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        local kitty_theme = os.getenv("KITTY_THEME")
        vim.cmd.colorscheme(kitty_theme or "catppuccin-frappe")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        local kitty_theme = os.getenv("KITTY_THEME")
        vim.cmd.colorscheme(kitty_theme or "catppuccin-latte")
      end,
    },
    cond = function() -- Not Using SSH or root
      local ssh = os.getenv("SSH_TTY") or false
      local user = os.getenv("USER") or ""
      local root = string.find(user, "root")
      return not ssh and not root
    end,
  },
}
