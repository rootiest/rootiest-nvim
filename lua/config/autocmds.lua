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

-- Set up autocommands and highlight settings
local load_highlight = require("utils.highlight")
-- load_highlight.setup_indent_highlight()
load_highlight.setup_autocommands()
load_highlight.setup_dashboard_highlight()
