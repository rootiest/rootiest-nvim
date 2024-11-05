---@module "data.autocmd"
--- This module defines the autocommands for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Autocommands                     │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.cpp_picker = function()
  augroup("cpp_picker", { clear = true })
  -- C++ Picker
  autocmd("FileType", {
    group = "cpp_picker",
    pattern = { "cpp", "c", "h", "hpp" },
    callback = function()
      require("data.func").add_keymap(require("data.keys").cpp_picker)
    end,
  })
end

M.minifiles = {
  ---@function Function to dynamically resize the preview window
  dynamic_resize = function()
    local function update_width_preview()
      local multiplier = 0.25
      if vim.g.minifiles_width ~= nil then
        multiplier = vim.g.minifiles_width
      end
      if package.loaded["mini.files"] then
        -- Obtain the existing config
        local config = require("mini.files").config
        -- Update the width_preview based on the current window size
        if multiplier > 1 then
          -- If the multiplier is greater than 1, use as the preview width
          config.windows.width_preview = multiplier
        else
          -- Otherwise, use the current window width multiplied by the multiplier
          config.windows.width_preview = math.floor(vim.o.columns * multiplier)
        end
        -- Apply the updated config
        require("mini.files").setup(config)
      end
    end

    -- Flag to determine if mini.files is currently in use
    local is_mini_files_active = false

    -- Autocommand group to handle dynamic resizing
    augroup("MiniFilesDynamicWidth", { clear = true })

    -- Handle mini.files open event to set the flag
    autocmd("User", {
      group = "MiniFilesDynamicWidth",
      pattern = "MiniFilesExplorerOpen",
      callback = function()
        is_mini_files_active = true
      end,
    })

    -- Handle mini.files close event to reset the flag and update the preview width
    autocmd("User", {
      group = "MiniFilesDynamicWidth",
      pattern = "MiniFilesExplorerClose",
      callback = function()
        is_mini_files_active = false
        update_width_preview()
      end,
    })

    -- Handle window resize event
    autocmd("VimResized", {
      group = "MiniFilesDynamicWidth",
      callback = function()
        if is_mini_files_active then
          -- Defer the update until mini.files closes
          autocmd("User", {
            group = "MiniFilesDynamicWidth",
            pattern = "MiniFilesExplorerClose",
            callback = update_width_preview,
            once = true, -- Ensure this runs only once
          })
        else
          -- If mini.files is not active, update immediately
          update_width_preview()
        end
      end,
    })
  end,
}

return M
