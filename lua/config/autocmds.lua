--- @module "config.autocmds"
--- This module defines the autocommands for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                      Autocommands                       │
--          ╰─────────────────────────────────────────────────────────╯
local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- GIT CONFLICT MARKERS
-- if there are conflicts, jump to first conflict, highlight conflict markers,
-- and disable diagnostics (simplified version of `git-conflict.nvim`)
autogrp("GitConflictMarkers", { clear = true })
autocmd({ "BufEnter", "FocusGained" }, {
  group = "GitConflictMarkers",
  callback = function(ctx)
    local hlgroup = "DiagnosticVirtualTextInfo" -- CONFIG

    if not vim.api.nvim_buf_is_valid(ctx.buf) then
      return
    end
    vim.system(
      { "git", "diff", "--check", "--", vim.api.nvim_buf_get_name(ctx.buf) },
      {},
      vim.schedule_wrap(function(out)
        local noConflicts = out.code == 0
        local noGitRepo =
          vim.startswith(out.stdout, "warning: Not a git repository")
        if noConflicts or noGitRepo then
          return
        end

        local ns = vim.api.nvim_create_namespace("conflictMarkers")
        local firstConflict
        for conflictLnum in out.stdout:gmatch("(%d+): leftover conflict marker") do
          local lnum = tonumber(conflictLnum)
          vim.api.nvim_buf_add_highlight(ctx.buf, ns, hlgroup, lnum - 1, 0, -1)
          if not firstConflict then
            firstConflict = lnum
          end
        end
        if not firstConflict then
          return
        end

        vim.api.nvim_win_set_cursor(0, { firstConflict, 0 })
        vim.diagnostic.enable(false, { bufnr = ctx.buf })
        vim.notify_once(
          "Conflict markers found.",
          nil,
          { title = "Git Conflicts" }
        )
      end)
    )
  end,
})

-- LazyGit root detection
if pcall(require, "lazygit.utils") then
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
      require("lazygit.utils").project_root_dir()
    end,
  })
end

-- TodoFzfLua command override to use Telescope
-- when fzf-lua is not installed
autogrp("TodoFzfLua", { clear = true })
autocmd({ "BufEnter" }, {
  group = "TodoFzfLua",
  callback = function()
    if not pcall(require, "fzf-lua") then
      vim.cmd([[command! -nargs=* TodoFzfLua :TodoTelescope]])
    end
  end,
})

--  ━━━━━━━━━━━━━━━━━━━━━━━ Set up Qalc keymappings ━━━━━━━━━━━━━━━━━━━━━━━
if pcall(require, "qalc") then
  -- Create a group for filetype-specific mappings
  vim.api.nvim_create_augroup("QalcFileTypeMappings", { clear = true })

  -- Create an autocommand for the qalc filetype
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "qalc",
    group = "QalcFileTypeMappings",
    callback = function()
      -- Set the key mapping: 'y' to run the :QalcYank command in normal mode
      vim.keymap.set( -- Yank Result
        "n",
        "y",
        ":QalcYank +<CR>",
        { noremap = true, silent = true }
      )
      -- Set the key mapping: 'q' to run the :QalcClose command in normal mode
      vim.keymap.set( -- Close Qalc
        "n",
        "q",
        ":QalcClose<CR>",
        { noremap = true, silent = true }
      )
    end,
  })

  -- Define a custom command to close the Qalc buffer
  vim.api.nvim_create_user_command("QalcClose", function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name ~= "" then
      vim.cmd("bd!")
    else
      -- If the buffer has no name, just remove it without invoking :bd!
      vim.api.nvim_buf_delete(0, { force = true })
    end
  end, { bang = true })
end

--  ━━━━━━━━━━━━━━━━━━━━━━━━━━ Set up highlights ━━━━━━━━━━━━━━━━━━━━━━━━━━
local load_highlight = require("utils.highlight")
load_highlight.setup_autocommands()
load_highlight.setup_dashboard_highlight()
