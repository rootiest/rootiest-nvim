--          ╭─────────────────────────────────────────────────────────╮
--          │                        Dashboard                        │
--          ╰─────────────────────────────────────────────────────────╯
local data = require("data")

return {
  -- Dashboard
  enabled = false,
  "nvimdev/dashboard-nvim",
  event = "UIEnter",
  version = false,
  opts = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local logo_path = vim.fs.joinpath(vim.fn.stdpath("config"), "logo/")
    local height, width = vim.fn.winheight(0), vim.fn.winwidth(0)
    local logo_file
    local logo_dimensions = { width = 0, height = 0 }

    if height >= 80 and width >= 80 then
      logo_file = "rootiest.txt"
    elseif height >= 48 and width >= 48 then
      logo_file = "xerneas.ans"
    elseif width >= 100 then
      logo_file = "pikachu.ans"
    elseif width >= 80 then
      logo_file = "tall.txt"
    elseif width >= 50 then
      logo_file = "small.txt"
    else
      logo_file = "tiny.txt"
    end

    if logo_file == "snorlax.ans" then
      logo_dimensions = { width = 53, height = 25 }
    elseif logo_file == "porygon-z.ans" then
      logo_dimensions = { width = 28, height = 18 }
    elseif logo_file == "pikachu.ans" then
      logo_dimensions = { width = 22, height = 11 }
    elseif logo_file == "taco.ans" then
      logo_dimensions = { width = 33, height = 15 }
    elseif logo_file == "nvim.ans" then
      logo_dimensions = { width = 35, height = 20 }
    elseif logo_file == "marshadow.ans" then
      logo_dimensions = { width = 28, height = 17 }
    elseif logo_file == "eiscue.ans" then
      logo_dimensions = { width = 22, height = 18 }
    elseif logo_file == "xerneas.ans" then
      logo_dimensions = { width = 39, height = 24 }
    elseif logo_file == "rootiest.ans" then
      logo_dimensions = { width = 65, height = 27 }
    end

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
        tabline = true,
      },
      -- By default, use ANSI art header
      preview = {
        command = "bat -pp | bat -pp",
        file_path = logo_path .. logo_file,
        file_width = logo_dimensions.width,
        file_height = logo_dimensions.height,
      },
      config = {
        center = data.dash.choices,
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            -- "⚡ Neovim loaded "
            "󱐋  Neovim loaded "
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

    -- if logo_file extension is not .ans or .png then read the content and add it to the header
    if logo_file:sub(-4) ~= ".ans" and logo_file:sub(-4) ~= ".png" then
      local logo_content = vim.fn.readfile(logo_path .. logo_file)
      local LOGO = "\n\n" .. table.concat(logo_content, "\n") .. "\n\n"
      opts.config.header = vim.split(LOGO, "\n")
      opts.preview = nil
    end

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- Open dashboard after closing lazy
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
}
