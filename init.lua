-- Copyright (C) 2024 Chris Laprade (chris@rootiest.com)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
--          ██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗
--          ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝
--          ██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║
--          ██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║
--          ██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║
--          ╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝
--
--               ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
--               ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
--               ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
--               ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
--               ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
--               ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Rootiest NVim ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ Configuration ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
-- ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

-- ---------------------------------- LAZY -------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
	-- stylua: ignore
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- --------------------------------- PLUGINS -----------------------------------
require("lazy").setup({
  -- Setup lazy
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { "vhyrro/luarocks.nvim", priority = 1000, config = true },
    {
      "nvimdev/dashboard-nvim",
      lazy = false,
      opts = function()
        -- if line length is greater than 80, use fancy mode
        if vim.fn.winwidth(0) >= 100 then
          LOGO = [[
██████╗  ██████╗  ██████╗ ████████╗██╗███████╗███████╗████████╗    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝██║██╔════╝██╔════╝╚══██╔══╝    ████╗  ██║██║   ██║██║████╗ ████║
██████╔╝██║   ██║██║   ██║   ██║   ██║█████╗  ███████╗   ██║       ██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██╗██║   ██║██║   ██║   ██║   ██║██╔══╝  ╚════██║   ██║       ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║╚██████╔╝╚██████╔╝   ██║   ██║███████╗███████║   ██║       ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚══════╝╚══════╝   ╚═╝       ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]]
        elseif vim.fn.winwidth(0) >= 80 then
          LOGO = [[
 ███████████                      █████     ███                    █████   
░░███░░░░░███                    ░░███     ░░░                    ░░███    
 ░███    ░███   ██████   ██████  ███████   ████   ██████   █████  ███████  
 ░██████████   ███░░███ ███░░███░░░███░   ░░███  ███░░███ ███░░  ░░░███░   
 ░███░░░░░███ ░███ ░███░███ ░███  ░███     ░███ ░███████ ░░█████   ░███    
 ░███    ░███ ░███ ░███░███ ░███  ░███ ███ ░███ ░███░░░   ░░░░███  ░███ ███
 █████   █████░░██████ ░░██████   ░░█████  █████░░██████  ██████   ░░█████ 
░░░░░   ░░░░░  ░░░░░░   ░░░░░░     ░░░░░  ░░░░░  ░░░░░░  ░░░░░░     ░░░░░  
 ██████   █████ █████   █████  ███                 
░░██████ ░░███ ░░███   ░░███  ░░░                  
 ░███░███ ░███  ░███    ░███  ████  █████████████  
 ░███░░███░███  ░███    ░███ ░░███ ░░███░░███░░███ 
 ░███ ░░██████  ░░███   ███   ░███  ░███ ░███ ░███ 
 ░███  ░░█████   ░░░█████░    ░███  ░███ ░███ ░███ 
 █████  ░░█████    ░░███      █████ █████░███ █████
░░░░░    ░░░░░      ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ 

]]
        else
          LOGO = [[
░█▀▄░█▀█░█▀█░▀█▀░▀█▀░█▀▀░█▀▀░▀█▀░░░█▀█░█░█░▀█▀░█▄█
░█▀▄░█░█░█░█░░█░░░█░░█▀▀░▀▀█░░█░░░░█░█░▀▄▀░░█░░█░█
░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀░▀░░▀░░▀▀▀░▀░▀
]]
        end
        LOGO = string.rep("\n", 8) .. LOGO .. "\n\n"
        local opts = {
          theme = "doom",
          hide = {
            statusline = false,
          },
          config = {
            header = vim.split(LOGO, "\n"),
            -- stylua: ignore
            center = {
              { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
              { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
              { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
              { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
              { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
              { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
              { action = 'RemoteStart',                                    desc = " Remote Session",  icon = "󰢹 ", key = "v" },
              { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
              { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
              { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
            },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return {
                "⚡ Neovim loaded "
                  .. stats.loaded
                  .. "/"
                  .. stats.count
                  .. " plugins in "
                  .. ms
                  .. "ms",
              }
            end,
          },
        }
        for _, button in ipairs(opts.config.center) do
          button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
          button.key_format = "  %s"
        end
        -- open dashboard after closing lazy
        if vim.o.filetype == "lazy" then
          vim.api.nvim_create_autocmd("WinClosed", {
            pattern = tostring(vim.api.nvim_get_current_win()),
            once = true,
            callback = function()
              vim.schedule(function()
                vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
              end)
            end,
          })
        end
        return opts
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          integrations = {
            cmp = true,
            diffview = true,
            dashboard = true,
            gitsigns = true,
            nvimtree = true,
            neotree = true,
            treesitter = true,
            markdown = true,
            sandwich = true,
            which_key = true,
            telescope = { enabled = true, style = "nvchad" },
            illuminate = { enabled = true, lsp = true },
            notify = true,
            notifier = true,
            dap = true,
            dap_ui = true,
            ts_rainbow2 = true,
            rainbow_delimiters = true,
            lsp_trouble = true,
            noice = true, -- codespell:ignore noice
            native_lsp = {
              enabled = true,
              virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
              },
              underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
              },
              inlay_hints = { background = true },
            },
            mini = { enabled = true, indentscope_color = "mauve" },
          },
        })
      end,
    },
    { "Shatur/neovim-ayu", lazy = true },
    {
      "folke/persistence.nvim",
      event = "BufReadPre",
      opts = {},
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({
          defaults = {
            dynamic_preview_title = true,
            prompt_prefix = " ",
            selection_caret = " ",
          },
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
        })
      end,
    },
    {
      "gorbit99/codewindow.nvim",
      version = false,
      config = function()
        require("codewindow").setup({
          active_in_terminals = false, -- Should the minimap activate for terminal buffers
          auto_enable = true, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
          exclude_filetypes = { "help", "dashboard" }, -- Choose certain filetypes to not show minimap on
          max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
          max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
          minimap_width = 10, -- The width of the text part of the minimap
          use_lsp = true, -- Use the builtin LSP to show errors and warnings
          use_treesitter = true, -- Use nvim-treesitter to highlight the code
          use_git = true, -- Show small dots to indicate git additions and deletions
          width_multiplier = 4, -- How many characters one dot represents
          z_index = 1, -- The z-index the floating window will be on
          show_cursor = true, -- Show the cursor position in the minimap
          screen_bounds = "background", -- How the visible area is displayed, "lines": lines above and below, "background": background color
          window_border = "none", -- The border style of the floating window (accepts all usual options)
          relative = "win", -- What will be the minimap be placed relative to, "win": the curre
          events = {
            "TextChanged",
            "InsertLeave",
            "DiagnosticChanged",
            "FileWritePost",
          }, -- Events that update the code window
        })
        require("codewindow").apply_default_keybinds()
      end,
    },
    {
      "folke/edgy.nvim",
      event = "VeryLazy",
      init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
      end,
    },
    {
      "echasnovski/mini.icons",
      version = false,
      lazy = true,
      config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
      end,
    },
    {
      "Exafunction/codeium.vim",
      lazy = true,
      event = "BufEnter",
      config = function()
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.keymap.set("n", "<C-S-g>", function()
          return vim.fn["codeium#Chat"]()
        end, { expr = true, silent = true })
      end,
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
          line_num = { style = "#806d9c", enable = false },
        })
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
        -- Keybinds
        vim.api.nvim_set_keymap(
          "n",
          "<c-/>",
          ":ToggleTerm<cr>",
          { noremap = true, desc = " Open Terminal" }
        )
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      lazy = true,
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("neo-tree").setup({
          source_selector = {
            winbar = true,
            statusline = false,
          },
        })
      end,
    },
    { "lewis6991/gitsigns.nvim" },
    {
      "jghauser/kitty-runner.nvim",
      cond = function() -- Using Kitty
        local term = os.getenv("TERM")
        return term and string.find(term, "kitty")
      end,
    },
    {
      "knubie/vim-kitty-navigator",
      cond = function() -- Using Kitty
        local term = os.getenv("TERM")
        return term and string.find(term, "kitty")
      end,
    },
    {
      "3rd/image.nvim",
      cond = function() -- Not Using SSH or root
        local ssh = os.getenv("SSH_TTY")
        local user = os.getenv("USER")
        return not ssh and user ~= "root"
      end,
    },
    {
      "f-person/auto-dark-mode.nvim",
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
        local ssh = os.getenv("SSH_TTY")
        local user = os.getenv("USER")
        return not ssh and user ~= "root"
      end,
    },
    {
      "xiyaowong/transparent.nvim",
    },
    {
      "Pocco81/auto-save.nvim",
      config = function()
        require("auto-save").setup({})
      end,
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
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "amitds1997/remote-nvim.nvim",
      version = "*", -- Pin to GitHub releases
      dependencies = {
        "nvim-lua/plenary.nvim", -- For standard functions
        "MunifTanjim/nui.nvim", -- To build the plugin UI
        "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
      },
      config = true,
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup({
          modes = {
            preview_float = {
              mode = "diagnostics",
              preview = {
                type = "float",
                relative = "editor",
                border = "rounded",
                title = "Preview",
                title_pos = "center",
                position = { 0, -2 },
                size = { width = 0.3, height = 0.3 },
                zindex = 200,
              },
            },
          },
        })
      end,
    },
    {
      "Bekaboo/deadcolumn.nvim",
      lazy = true,
    },
    {
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
    },
    {
      "mistricky/codesnap.nvim",
      build = "make",
      keys = {
        {
          "<leader>cc",
          "<cmd>CodeSnap<cr>",
          mode = "x",
          desc = "󰹑 Save selected code snapshot into clipboard",
        },
        {
          "<leader>cs",
          "<cmd>CodeSnapSave<cr>",
          mode = "x",
          desc = "󰉏 Save selected code snapshot in ~/Pictures",
        },
        {
          "<leader>ch",
          "<cmd>CodeSnapHighlight<cr>",
          mode = "x",
          desc = " Highlight and snapshot selected code into clipboard",
        },
        {
          "<leader>cp",
          "<cmd>CodeSnapASCII<cr>",
          mode = "x",
          desc = " Save ASCII code snapshot into clipboard",
        },
      },
      opts = {
        save_path = "~/Pictures/Screenshots/",
        has_breadcrumbs = true,
        show_workspace = true,
        --has_line_number = true,
        bg_theme = "default",
        watermark = "Rootiest Snippets",
        code_font_family = "CaskaydiaCove NF",
        code_font_size = 12,
      },
    },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = {} },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- ---------------------------------- STYLE ------------------------------------

-- Apply the default colorscheme
local kitty_theme = os.getenv("KITTY_THEME")
vim.cmd.colorscheme(kitty_theme or "catppuccin-frappe")
-- Set the colorscheme palette
if vim.g.colors_name == "catppuccin-frappe" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("frappe")
elseif vim.g.colors_name == "catppuccin-latte" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("latte")
elseif vim.g.colors_name == "catppuccin-mocha" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("mocha")
elseif vim.g.colors_name == "catppuccin-macchiato" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("macchiato")
elseif vim.g.colors_name == "tokyonight-night" or "tokyonight" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("mocha")
elseif vim.g.colors_name == "ayu" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("mocha")
elseif vim.g.colors_name == "ayu-mirage" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("frappe")
elseif vim.g.colors_name == "tokyonight-day" or "ayu-light" then
  THEMEPALETTE = require("catppuccin.palettes").get_palette("latte")
else
  THEMEPALETTE = {
    bg = "#282c34",
    fg = "#abb2bf",
    overlay0 = "#abb2bf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }
end

-- Set GUI font
vim.opt.guifont = "MonaspiceKr Nerd Font Mono:#e-subpixelantialias:h13"
vim.g.have_nerd_font = true

-- DeadColumn

local dead_opts = {
  scope = "line", ---@type string|fun(): integer
  ---@type string[]|fun(mode: string): boolean
  modes = function(mode)
    return mode:find("^[ictRss\x13]") ~= nil
  end,
  blending = {
    threshold = 0.9,
    colorcode = THEMEPALETTE.overlay0,
    hlgroup = { "Normal", "bg" },
  },
  warning = {
    alpha = 0.4,
    offset = 0,
    colorcode = THEMEPALETTE.error,
    hlgroup = { "Error", "bg" },
  },
  extra = {
    ---@type string?
    follow_tw = "80",
  },
}
require("deadcolumn").setup(dead_opts)
vim.cmd(":set colorcolumn=120")

-- ------------------------------- CLIENT APPS ---------------------------------

if vim.g.neovide then
  -- ----------------------- Neovide -------------------------
  -- refresh rate and translucency
  vim.g.neovide_refresh_rate = 170
  vim.g.neovide_transparency = 0.85
  vim.g.neovide_window_blurred = true
  -- Neovide has its own transparency
  vim.cmd(":TransparentDisable")
  -- cursor fx
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_particle_density = 16.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.6
  vim.g.neovide_cursor_vfx_particle_phase = 1.2
  vim.g.neovide_cursor_vfx_particle_curl = 1.0
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  -- floating shadow
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  -- scaling
  vim.g.neovide_scale_factor = 1.0
  -- padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Simulate kitty copy-and-paste from system clipboard
  -- in normal mode
  vim.cmd(":nnoremap <silent> <C-v> :r !xsel -b<cr>")
  vim.cmd(":nnoremap <silent> <C-c> :w !xsel -i -b<cr>")
  -- and in visual mode
  vim.cmd(":vnoremap <silent> <C-v> :r !xsel -b<cr>")
  vim.cmd(":vnoremap <silent> <C-c> :w !xsel -i -b<cr>")
  -- and in command mode
  vim.cmd(":cnoremap <silent> <C-v> <C-r>+")
  vim.cmd(":cnoremap <silent> <C-c> <C-r>+")
  -- and in insert mode
  vim.cmd(":inoremap <silent> <C-v> <C-r>+")
  vim.cmd(":inoremap <silent> <C-c> <C-r>+")
else
  if vim.env.TERM:find("kitty") then
    -- ------------------------ Kitty --------------------------
    if not vim.env.SSH_TTY then
      if vim.env.USER ~= "root" then
        -- Image Preview
        require("image").setup()
      end
      -- Transparency
      vim.cmd(":TransparentEnable")
    else
      -- SSH
      vim.cmd(":TransparentDisable")
    end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    vim.cmd("let g:kitty_navigator_no_mappings = 1")
    vim.cmd(":nnoremap <silent> {Left-Mapping} :KittyNavigateLeft<cr>")
    vim.cmd(":nnoremap <silent> {Down-Mapping} :KittyNavigateDown<cr>")
    vim.cmd(":nnoremap <silent> {Up-Mapping} :KittyNavigateUp<cr>")
    vim.cmd(":nnoremap <silent> {Right-Mapping} :KittyNavigateRight<cr>")
  end
end

-- ------------------------------ KEY BINDINGS ---------------------------------

-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- Panel Navigation
vim.api.nvim_set_keymap(
  "n",
  "<A-Left>",
  [[<Cmd>wincmd h<CR>]],
  { noremap = true, desc = " Go to Window Left" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Up>",
  [[<Cmd>wincmd j<CR>]],
  { noremap = true, desc = " Go to Window Up" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Down>",
  [[<Cmd>wincmd k<CR>]],
  { noremap = true, desc = " Go to Window Down" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-Right>",
  [[<Cmd>wincmd l<CR>]],
  { noremap = true, desc = " Go to Window Right" }
)

-- Terminal navigation
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
