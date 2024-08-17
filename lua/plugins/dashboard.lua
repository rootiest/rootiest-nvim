--          ╭─────────────────────────────────────────────────────────╮
--          │                        Dashboard                        │
--          ╰─────────────────────────────────────────────────────────╯
return {
  -- Dashboard
  "nvimdev/dashboard-nvim",
  event = "UIEnter",
  opts = function()
    local logo_path = vim.fn.stdpath("config") .. "/logo/"
    local height, width = vim.fn.winheight(0), vim.fn.winwidth(0)
    local logo_file

    if height >= 80 and width >= 80 then
      logo_file = "rootiest.txt"
    elseif height >= 48 and width >= 48 then
      logo_file = "taco.ans"
    elseif width >= 100 then
      logo_file = "long.txt"
    elseif width >= 80 then
      logo_file = "tall.txt"
    elseif width >= 50 then
      logo_file = "small.txt"
    else
      logo_file = "tiny.txt"
    end

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
        tabline = true,
      },
      -- By default, use ANSI art header
      preview = {
        command = "cat",
        file_path = logo_path .. logo_file,
        file_width = 33,
        file_height = 15,
      },
      config = {
        center = {
          { -- Find File
            action = "lua LazyVim.pick()()",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          { -- New File
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          { -- Open Recent Files
            action = 'lua LazyVim.pick("oldfiles")()',
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          { -- Find Text
            action = 'lua LazyVim.pick("live_grep")()',
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          { -- LazyGit
            action = "LazyGit",
            desc = " LazyGit",
            icon = " ",
            key = "z",
          },
          { -- Config
            action = "lua LazyVim.pick.config_files()()",
            desc = " Config",
            icon = " ",
            key = "c",
          },
          { -- Restore Session
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          { -- Remote Session
            action = 'lua require("config.rootiest").load_remote()',
            desc = " Remote Session",
            icon = "󰢹 ",
            key = "S",
          },
          { -- Lazy
            action = "Lazy",
            desc = " Lazy",
            icon = "󰒲 ",
            key = "l",
          },
          { -- Quit
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
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
