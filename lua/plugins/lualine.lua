--          ╭─────────────────────────────────────────────────────────╮
--          │                         Lualine                         │
--          ╰─────────────────────────────────────────────────────────╯

local utils = require("utils.rootiest")

return {
  "nvim-lualine/lualine.nvim",
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

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter" },
        },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode" },
        },
        lualine_b = {
          { "branch" },
        },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          -- stylua: ignore
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.command.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return LazyVim.ui.fg("Statement") end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return LazyVim.ui.fg("Debug") end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return LazyVim.ui.fg("Special") end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            {
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
            },
          },
          {
            function()
              return require("utils.wakatime_stats").get_icon_with_text()
            end,
            color = function()
              local wakatime_stats = require("utils.wakatime_stats")
              return wakatime_stats.get_color()
            end,
            cond = function()
              return utils.is_window_wide_enough(100)
            end,
          },
          {
            function()
              return require("utils.music_stats").get_icon_with_text()
            end,
            cond = function()
              return utils.is_window_wide_enough(100)
            end,
          },
        },
        lualine_y = {
          {
            function()
              return vim.fn.wordcount().words
            end,
            icon = " ",
            cond = function()
              return utils.is_window_wide_enough(80)
            end,
          },
          {
            "progress",
            separator = " ",
            padding = { left = 1, right = 0 },
            cond = function()
              return utils.is_window_wide_enough(60)
            end,
          },
          {
            "location",
            padding = { left = 0, right = 1 },
            cond = function()
              return utils.is_window_wide_enough(40)
            end,
          },
          {
            "selection_count",
            cond = function()
              return utils.is_window_wide_enough(120)
            end,
          },
          {
            "filesize",
            cond = function()
              return utils.is_window_wide_enough(100)
            end,
          },
          {
            function()
              return require("arrow.statusline").text_for_statusline_with_icons()
            end,
            cond = function()
              return utils.is_window_wide_enough(100)
            end,
          },
        },
        lualine_z = {
          {
            require("recorder").recordingStatus,
            color = "CurSearch",
            separator = { left = "", right = "" },
          },
          {
            "searchcount",
            color = "CurSearch",
            separator = { left = "", right = "" },
            icon = "󰍉 ",
          },
          {
            function()
              return "  " .. os.date("%R")
            end,
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
