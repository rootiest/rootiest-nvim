--          ╭─────────────────────────────────────────────────────────╮
--          │             Setup Git Signs for Mini.Files              │
--          ╰─────────────────────────────────────────────────────────╯

local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
local autocmd = vim.api.nvim_create_autocmd
local _, MiniFiles = pcall(require, "mini.files")

-- Cache for git status
local gitStatusCache = {}
local cacheTimeout = 2000 -- Cache timeout in milliseconds

---@type table<string, {symbol: string, hlGroup: string}>
---@param status string
---@return string symbol, string hlGroup
local function mapSymbols(status)
  local statusMap = {
    -- stylua: ignore start 
    [" M"] = { symbol = "•", hlGroup  = "GitSignsChange"}, -- Modified in the working directory
    ["M "] = { symbol = "✹", hlGroup  = "GitSignsChange"}, -- modified in index
    ["MM"] = { symbol = "≠", hlGroup  = "GitSignsChange"}, -- modified in both working tree and index
    ["A "] = { symbol = "+", hlGroup  = "GitSignsAdd"   }, -- Added to the staging area, new file
    ["AA"] = { symbol = "≈", hlGroup  = "GitSignsAdd"   }, -- file is added in both working tree and index
    ["D "] = { symbol = "-", hlGroup  = "GitSignsDelete"}, -- Deleted from the staging area
    ["AM"] = { symbol = "⊕", hlGroup  = "GitSignsChange"}, -- added in working tree, modified in index
    ["AD"] = { symbol = "-•", hlGroup = "GitSignsChange"}, -- Added in the index and deleted in the working directory
    ["R "] = { symbol = "→", hlGroup  = "GitSignsChange"}, -- Renamed in the index
    ["U "] = { symbol = "‖", hlGroup  = "GitSignsChange"}, -- Unmerged path
    ["UU"] = { symbol = "⇄", hlGroup  = "GitSignsAdd"   }, -- file is unmerged
    ["UA"] = { symbol = "⊕", hlGroup  = "GitSignsAdd"   }, -- file is unmerged and added in working tree
    ["??"] = { symbol = "?", hlGroup  = "GitSignsDelete"}, -- Untracked files
    ["!!"] = { symbol = "!", hlGroup  = "GitSignsChange"}, -- Ignored files
    -- stylua: ignore end
  }

  local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
  return result.symbol, result.hlGroup
end

---@param cwd string
---@param callback function
---@return nil
local function fetchGitStatus(cwd, callback)
  local function on_exit(content)
    if content.code == 0 then
      callback(content.stdout)
      vim.g.content = content.stdout
    end
  end
  vim.system(
    { "git", "status", "--ignored", "--porcelain" },
    { text = true, cwd = cwd },
    on_exit
  )
end

---@param str string?
local function escapePattern(str)
  ---@diagnostic disable-next-line: need-check-nil
  return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

---@param buf_id integer
---@param gitStatusMap table
---@return nil
local function updateMiniWithGit(buf_id, gitStatusMap)
  vim.schedule(function()
    local nlines = vim.api.nvim_buf_line_count(buf_id)
    local cwd = vim.fs.root(buf_id, ".git")
    local escapedcwd = escapePattern(cwd)
    if vim.fn.has("win32") == 1 then
      escapedcwd = escapedcwd:gsub("\\", "/")
    end

    for i = 1, nlines do
      local entry = MiniFiles.get_fs_entry(buf_id, i)
      if not entry then
        break
      end
      local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
      local status = gitStatusMap[relativePath]

      if status then
        local symbol, hlGroup = mapSymbols(status)
        vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
          sign_text = symbol,
          sign_hl_group = hlGroup,
          priority = 2,
        })
      else
      end
    end
  end)
end

-- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
---@param content string
---@return table
local function parseGitStatus(content)
  local gitStatusMap = {}
  -- lua match is faster than vim.split (in my experience )
  for line in content:gmatch("[^\r\n]+") do
    local status, filePath = string.match(line, "^(..)%s+(.*)")
    -- Split the file path into parts
    local parts = {}
    for part in filePath:gmatch("[^/]+") do
      table.insert(parts, part)
    end
    -- Start with the root directory
    local currentKey = ""
    for i, part in ipairs(parts) do
      if i > 1 then
        -- Concatenate parts with a separator to create a unique key
        currentKey = currentKey .. "/" .. part
      else
        currentKey = part
      end
      -- If it's the last part, it's a file, so add it with its status
      if i == #parts then
        gitStatusMap[currentKey] = status
      else
        -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
        if not gitStatusMap[currentKey] then
          gitStatusMap[currentKey] = status
        end
      end
    end
  end
  return gitStatusMap
end

---@param buf_id integer
---@return nil
local function updateGitStatus(buf_id)
  ---@diagnostic disable-next-line: param-type-mismatch
  if not vim.fs.root(vim.uv.cwd(), ".git") then
    return
  end

  local cwd = vim.fn.expand("%:p:h")
  local currentTime = os.time()
  if
    gitStatusCache[cwd]
    and currentTime - gitStatusCache[cwd].time < cacheTimeout
  then
    updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
  else
    fetchGitStatus(cwd, function(content)
      local gitStatusMap = parseGitStatus(content)
      gitStatusCache[cwd] = {
        time = currentTime,
        statusMap = gitStatusMap,
      }
      updateMiniWithGit(buf_id, gitStatusMap)
    end)
  end
end

---@return nil
local function clearCache()
  gitStatusCache = {}
end

local function augroup(name)
  return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
end

autocmd("User", {
  group = augroup("start"),
  pattern = "MiniFilesExplorerOpen",
  -- pattern = { "minifiles" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    updateGitStatus(bufnr)
  end,
})

autocmd("User", {
  group = augroup("close"),
  pattern = "MiniFilesExplorerClose",
  callback = function()
    clearCache()
  end,
})

autocmd("User", {
  group = augroup("update"),
  pattern = "MiniFilesBufferUpdate",
  callback = function(sii)
    local bufnr = sii.data.buf_id
    local cwd = vim.fn.expand("%:p:h")
    if gitStatusCache[cwd] then
      updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
    end
  end,
})
