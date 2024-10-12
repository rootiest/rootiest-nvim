--- @module "plugins.statusline.lualine"
--- This module defines the lualine plugin spec for the Neovim configuration.
--- This option uses the lualine plugin to create a statusline for Neovim
---
--- Activate this module by setting the 'vim.g.statusline' variable to 'lualine'
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Lualine                         │
--          ╰─────────────────────────────────────────────────────────╯

local wakatime_stats = require("utils.wakatime_stats")
local music_stats = require("utils.music_stats")
local data = require("data")
local funcs = data.func

-- Setup NeoMiniMap extension
-- local minimap_extension = require("neominimap.statusline").lualine_default
local neominimap = require("neominimap.statusline")
local minimap_extension = {
  sections = {
    lualine_a = {
      neominimap.plugin_name,
    },
    lualine_b = {
      { -- Branch
        "branch",
        separator = "",
        padding = { left = 1, right = 0 },
      },
    },
    lualine_c = {
      neominimap.shortname,
    },
    lualine_y = {
      { -- Progress
        "progress",
        separator = "",
        padding = { left = 0, right = 1 },
        icon = "",
      },
      neominimap.position,
    },
    lualine_z = {
      { -- Time
        "datetime",
        style = "%a %R",
        icon = " ",
        padding = { left = 0, right = 1 },
        on_click = function()
          vim.cmd("Telescope oldfiles")
        end,
      },
    },
  },
  filetypes = { "neominimap" },
}

-- Use lualine by default
if vim.g.statusline == nil then
  vim.g.statusline = "lualine"
end

-- function to process get_status() and set buffer variable to that data.
local neocodeium = require("neocodeium")
local function get_neocodeium_status(ev)
  local status, server_status = neocodeium.get_status()
  -- process this data, convert it to custom string/icon etc and set buffer variable

  -- Tables to map serverstatus and status to corresponding symbols
  local server_status_symbols = {
    [0] = "󰣺 ", -- Connected
    [1] = "󱤚 ", -- Connecting
    [2] = "󰣽 ", -- Disconnected
  }

  local status_symbols = {
    [0] = "󰚩 ", -- Enabled
    [1] = "󱚧 ", -- Disabled Globally
    [3] = "󱚢 ", -- Disabled for Buffer filetype
    [5] = "󱚠 ", -- Disabled for Buffer encoding
    [2] = "󱙻 ", -- Disabled for Buffer (catch-all)
  }

  -- Handle serverstatus and status fallback (safeguard against any unexpected value)
  local luacodeium = server_status_symbols[server_status] or "󰣼 "
  luacodeium = luacodeium .. (status_symbols[status] or "󱙻 ")
  vim.api.nvim_buf_set_var(ev.buf, "neocodeium_status", luacodeium)
end

-- Then only some of event fired we invoked this function
vim.api.nvim_create_autocmd("User", {
  group = ..., -- set some augroup here
  pattern = {
    "NeoCodeiumServerConnecting",
    "NeoCodeiumServerConnected",
    "NeoCodeiumServerStopped",
    "NeoCodeiumEnabled",
    "NeoCodeiumDisabled",
    "NeoCodeiumBufEnabled",
    "NeoCodeiumBufDisabled",
  },
  callback = get_neocodeium_status,
})

return { -- Lualine
  "nvim-lualine/lualine.nvim",
  cond = data.func.check_global_var("statusline", "lualine", "lualine"),

  dependencies = data.deps.lualine,
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local icons = LazyVim.config.icons

    -- Restore laststatus
    vim.o.laststatus = vim.g.lualine_laststatus

    -- Define todo-comments component

    -- Attempt to require the plugin and handle the case where it's not available
    local status, todos = pcall(require, "todos-lualine")

    local todos_component

    if not status then
      todos_component = nil -- Set to nil if the plugin is not loaded
    else
      todos_component = todos.component(data.types.todo.lualine())
    end

    local opts = {
      options = { -- General options
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter" },
        },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = { -- Sections
        lualine_a = {
          { -- Mode
            function()
              return data.types.mode.current.lualine()
            end,
            padding = { left = 1, right = 0 },
            separator = { left = "", right = "" },
          },
          { -- MultiCursors
            function()
              return data.func.mc_statusline().count
                .. data.func.mc_statusline().icon
            end,
            cond = function()
              return data.func.mc_statusline().cursors > 1
            end,
            color = function()
              return data.func.mc_statusline().color
            end,
            padding = { left = 1, right = 0 },
            separator = { left = "", right = "" },
          },
        },
        lualine_b = {
          { -- Branch
            "branch",
            separator = "",
            padding = { left = 1, right = 0 },
          },
          { -- Todo
            todos_component,
            cond = function()
              return funcs.is_window_wide_enough(100)
            end,
            padding = { left = 1, right = 0 },
            on_click = function()
              vim.cmd("TodoTelescope")
            end,
          },
          { -- Arrow
            function()
              return require("arrow.statusline").text_for_statusline_with_icons()
            end,
            cond = function()
              return funcs.is_window_wide_enough(100)
                and pcall(require, "arrow")
            end,
            padding = { left = 1, right = 0 },
            on_click = function()
              vim.cmd("Arrow open")
            end,
          },
        },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          { -- Diagnostics
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            padding = { left = 0, right = 0 },
          },
          { -- Filetype
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          { -- PrettyPath
            LazyVim.lualine.pretty_path(),
            padding = { left = 0, right = 0 },
            cond = function()
              return not string.find(vim.bo.filetype, "neovim_updater_term")
            end,
          },
          { -- Neovim Updater
            function()
              local ft = vim.bo.filetype
              if ft == "neovim_updater_term.updating" then
                return "Neovim Updating.."
              elseif ft == "neovim_updater_term.cloning" then
                return "Neovim Source Cloning.."
              elseif ft == "neovim_updater_term.changes" then
                return "Neovim Source Changelog"
              end
            end,
            icon = "󰅢 ",
            color = "lualine_a_terminal",
            separator = { left = "", right = "" },
            padding = { left = 0, right = 0 },
            cond = function()
              return string.find(vim.bo.filetype, "neovim_updater_term") ~= nil
            end,
          },
        },
        lualine_x = {
          -- stylua: ignore
          { -- Statement
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.command.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return LazyVim.ui.fg("Statement") end,
          },
          -- stylua: ignore
          { -- DAP Status
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return LazyVim.ui.fg("Debug") end,
          },
          -- stylua: ignore
          { -- Lazy Status
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return LazyVim.ui.fg("Special") end,
          },
          { -- Diff
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
              padding = { left = 0, right = 0 },
              on_click = function()
                if vim.g.statusline_clickable_git ~= false then
                  require("config.rootiest").toggle_lazygit_float()
                end
              end,
            },
            { -- GitSigns
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              cond = function()
                return funcs.is_window_wide_enough(200)
              end,
              padding = { left = 0, right = 0 },
              on_click = function()
                if vim.g.statusline_clickable_git ~= false then
                  require("config.rootiest").toggle_lazygit_float()
                end
              end,
            },
          },
          { -- Wakatime
            function()
              return wakatime_stats.get_icon_with_text()
            end,
            color = function()
              return wakatime_stats.get_color()
            end,
            cond = function()
              return funcs.is_window_wide_enough(100)
            end,
            padding = { left = 0, right = 1 },
          },
          { -- Music
            function()
              return music_stats.get_icon_with_text()
            end,
            cond = function()
              return funcs.is_window_wide_enough(100)
            end,
            padding = { left = 0, right = 1 },
          },
          { -- Neovim Updater Status
            function()
              return require("nvim_updater").get_statusline().icon_text
            end,
            color = function()
              return require("nvim_updater").get_statusline().color
            end,
            on_click = function()
              require("nvim_updater").show_new_commits({
                isupdate = true,
                short = true,
              })
            end,
            padding = { left = 1, right = 1 },
            cond = function()
              if not pcall(require, "nvim_updater") then
                return false
              end
              return not string.find(vim.bo.filetype, "neovim_updater_term")
            end,
          },
        },
        lualine_y = {
          { -- NeoCodeium Status
            function()
              return vim.b.neocodeium_status or "󰣽 "
            end,
            padding = { left = 0, right = 1 },
          },
          { -- Wordcount
            function()
              return vim.fn.wordcount().words
            end,
            icon = " ",
            cond = function()
              return funcs.is_window_wide_enough(80)
            end,
            padding = { left = 0, right = 1 },
            on_click = function()
              vim.cmd("Telescope current_buffer_fuzzy_find")
            end,
          },
          { -- Progress
            "progress",
            separator = "",
            padding = { left = 0, right = 1 },
            cond = function()
              return funcs.is_window_wide_enough(60)
            end,
            icon = "",
            on_click = function()
              vim.cmd("Telescope grep_string")
            end,
          },
          { -- Location
            "location",
            padding = { left = 0, right = 1 },
            cond = function()
              return funcs.is_window_wide_enough(40)
            end,
            on_click = function()
              vim.cmd("Telescope grep_string")
            end,
          },
          { -- Selection
            "selection_count",
            cond = function()
              return funcs.is_window_wide_enough(120)
            end,
            padding = { left = 0, right = 1 },
          },
          { -- Filesize
            "filesize",
            cond = function()
              return funcs.is_window_wide_enough(100)
            end,
            padding = { left = 0, right = 1 },
            icon = "",
            on_click = function()
              vim.cmd("Neotree reveal toggle")
            end,
            separator = { left = "", right = "" },
          },
          { -- Encoding
            "encoding",
            show_bomb = true,
            padding = { left = 0, right = 1 },
            separator = "",
            icon = "󱁻",
            on_click = function()
              vim.cmd("Telescope oldfiles")
            end,
          },
        },
        lualine_z = {
          { -- Recording
            require("recorder").recordingStatus,
            cond = function()
              return pcall(require, "recorder")
            end,
            color = "CurSearch",
            separator = { left = "", right = "" },
          },
          { -- Search
            "searchcount",
            color = "CurSearch",
            separator = { left = "", right = "" },
            icon = "󰍉 ",
            on_click = function()
              vim.cmd("Telescope current_buffer_fuzzy_find")
            end,
          },
          { -- Time
            "datetime",
            style = "%a %R",
            icon = " ",
            padding = { left = 0, right = 1 },
            on_click = function()
              vim.cmd("Telescope buffers")
            end,
            separator = { left = "", right = "" },
          },
        },
      },
      extensions = {
        "neo-tree",
        "lazy",
        "aerial",
        "fugitive",
        "fzf",
        "mason",
        "overseer",
        "toggleterm",
        "nvim-dap-ui",
        "quickfix",
        "symbols-outline",
        "trouble",
        minimap_extension,
      },
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
