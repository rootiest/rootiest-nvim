-- -----------------------------------------------------------------------------
-- -------------------------------- AUTOCMDS -----------------------------------
-- -----------------------------------------------------------------------------

-- -------------------------------- Commands -----------------------------------
-- Make :Q close all of the buffers
vim.api.nvim_create_user_command("Q", function()
  vim.cmd.bdelete()
  vim.cmd.qall()
end, { force = true })

-- ------------------------------ Auto-Commands --------------------------------
-- Autosave Colorscheme
-- When the colorscheme changes, store the name in .colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Store colorscheme name",
  callback = function()
    print("colorscheme:", vim.g.colors_name)
    vim.fn.writefile(
      { vim.g.colors_name },
      vim.fn.stdpath("config") .. "/.colorscheme"
    )
  end,
})

-- GIT CONFLICT MARKERS
-- if there are conflicts, jump to first conflict, highlight conflict markers,
-- and disable diagnostics (simplified version of `git-conflict.nvim`)
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
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
