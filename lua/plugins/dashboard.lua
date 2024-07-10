return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function()
    if vim.fn.winheight(0) >= 80 and vim.fn.winwidth(0) >= 80 then
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/rootiest.txt"), "\n")
    elseif vim.fn.winheight(0) >= 48 and vim.fn.winwidth(0) >= 48 then
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/nvim.txt"), "\n")
    elseif vim.fn.winwidth(0) >= 100 then
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/long.txt"), "\n")
    elseif vim.fn.winwidth(0) >= 80 then
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/tall.txt"), "\n")
    elseif vim.fn.winwidth(0) >= 50 then
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/small.txt"), "\n")
    else
      LOGO = table.concat(vim.fn.readfile(vim.fn.stdpath("config") .. "/logo/tiny.txt"), "\n")
    end
    LOGO = "\n\n" .. LOGO .. "\n\n"
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
            { action = "LazyGit",                                        desc = " LazyGit",         icon = " ", key = "G" },
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
}
