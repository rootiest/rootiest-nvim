--          ╭─────────────────────────────────────────────────────────╮
--          │                         Lualine                         │
--          ╰─────────────────────────────────────────────────────────╯

local utils = require("utils")
local rootils = utils.rootiest

local function apply_todo_highlights(status_string)
  -- Define patterns and associated highlight groups
  local patterns = {
    { icon = "", hl = "lualine_c_diagnostics_info_normal" },
    { icon = "", hl = "lualine_c_diagnostics_warning_normal" },
    { icon = "", hl = "lualine_c_diagnostics_warning_normal" },
    { icon = "", hl = "lualine_c_diagnostics_hint_normal" },
    { icon = "", hl = "lualine_c_diagnostics_hint_normal" },
  }

  -- Apply the highlights
  for _, pattern in ipairs(patterns) do
    status_string = status_string:gsub(
      vim.pesc(pattern.icon),
      "%#" .. pattern.hl .. "#" .. pattern.icon
    )
  end

  -- Reset highlight to normal after the string
  status_string = status_string .. "%#LualineNormal#"

  return status_string
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "bezhermoso/todos-lualine.nvim" },
    { "folke/todo-comments.nvim" },
  },
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

    local todos_component =
      require("todos-lualine").component(require("data").types.todo.lualine())

    -- todos_component = apply_todo_highlights(todos_component)

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
          { -- Mode
            "mode",
          },
        },
        lualine_b = {
          { -- Branch
            "branch",
          },
          { -- Arrow
            function()
              return require("arrow.statusline").text_for_statusline_with_icons()
            end,
            cond = function()
              return rootils.is_window_wide_enough(100)
            end,
          },
          { -- Todo
            todos_component,
            cond = function()
              return rootils.is_window_wide_enough(100)
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
          },
          { -- Filetype
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          { LazyVim.lualine.pretty_path() },
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
            },
          },
          { -- Wakatime
            function()
              return utils.wakatime_stats.get_icon_with_text()
            end,
            color = function()
              return utils.wakatime_stats.get_color()
            end,
            cond = function()
              return rootils.is_window_wide_enough(100)
            end,
          },
          { -- Music
            function()
              return utils.music_stats.get_icon_with_text()
            end,
            cond = function()
              return rootils.is_window_wide_enough(100)
            end,
          },
        },
        lualine_y = {
          { -- Wordcount
            function()
              return vim.fn.wordcount().words
            end,
            icon = " ",
            cond = function()
              return rootils.is_window_wide_enough(80)
            end,
          },
          { -- Progress
            "progress",
            separator = " ",
            padding = { left = 1, right = 0 },
            cond = function()
              return rootils.is_window_wide_enough(60)
            end,
          },
          { -- Location
            "location",
            padding = { left = 0, right = 1 },
            cond = function()
              return rootils.is_window_wide_enough(40)
            end,
          },
          { -- Selection
            "selection_count",
            cond = function()
              return rootils.is_window_wide_enough(120)
            end,
          },
          { -- Filesize
            "filesize",
            cond = function()
              return rootils.is_window_wide_enough(100)
            end,
          },
        },
        lualine_z = {
          { -- Recording
            require("recorder").recordingStatus,
            color = "CurSearch",
            separator = { left = "", right = "" },
          },
          { -- Search
            "searchcount",
            color = "CurSearch",
            separator = { left = "", right = "" },
            icon = "󰍉 ",
          },
          { -- Time
            "datetime",
            style = "%a %R",
            icon = " ",
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
