---@module "data.autocmd"
--- This module defines the autocommands for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                        Autocommands                       │
--          ╰─────────────────────────────────────────────────────────╯
local M = {}

M.minifiles = function(opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id

      vim.keymap.set(
        "n",
        opts.mappings and opts.mappings.toggle_hidden or "g.",
        toggle_dotfiles,
        { buffer = buf_id, desc = "Toggle hidden files" }
      )

      vim.keymap.set(
        "n",
        opts.mappings and opts.mappings.change_cwd or "gc",
        files_set_cwd,
        { buffer = args.data.buf_id, desc = "Set cwd" }
      )

      map_split(
        buf_id,
        opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s",
        "horizontal",
        false
      )
      map_split(
        buf_id,
        opts.mappings and opts.mappings.go_in_vertical or "<C-w>v",
        "vertical",
        false
      )
      map_split(
        buf_id,
        opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
        "horizontal",
        true
      )
      map_split(
        buf_id,
        opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V",
        "vertical",
        true
      )
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
      LazyVim.lsp.on_rename(event.data.from, event.data.to)
    end,
  })
end

return M
