---@module "utils.git"
--- This module provides functions to interact with GitGraph within Neovim.
--- It includes functions to draw, close, and toggle the GitGraph tab.

local M = {}

--- Opens the GitGraph in a new tab if it's not already open.
--- @return nil
function M.gitgraph_draw()
  -- Open gitgraph in a separate tab
  if vim.bo.filetype == "gitgraph" then
    return
  end
  vim.cmd("tab split")
  require("gitgraph").draw({}, { all = true, max_count = 5000 })
end

--- Closes the tab page if it is a GitGraph page.
--- @return nil
function M.gitgraph_close()
  -- Close the tab page if it is a gitgraph page
  if vim.bo.filetype == "gitgraph" then
    vim.cmd("tabclose")
  else
    return
  end
end

--- Toggles the GitGraph tab. Opens it if not already open, and closes it if it is.
--- @return nil
function M.gitgraph_toggle()
  -- Toggle gitgraph
  if vim.bo.filetype == "gitgraph" then
    M.gitgraph_close()
  else
    M.gitgraph_draw()
  end
end

return M
