--          ╭─────────────────────────────────────────────────────────╮
--          │                     LSP Operations                      │
--          ╰─────────────────────────────────────────────────────────╯

local M = {}

--- Function to get attached LSP server names
---@return string|nil list A list of attached lsp servers
function M.get_attached_lsp_clients()
  local clients =
    vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  if #clients == 0 then
    return nil
  else
    local names = {}
    for _, client in ipairs(clients) do
      table.insert(names, client.name)
    end
    return 'LSP~ ' .. table.concat(names, ', ')
  end
end

--- Function to print the list of attached LSP servers
function M.print_attached_lsp_clients()
  local clients = M.get_attached_lsp_clients()
  if clients == nil then
    print('No LSP clients attached')
  else
    print(clients)
  end
end

return M
