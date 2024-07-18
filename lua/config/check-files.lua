-- -----------------------------------------------------------------------------
-- ------------------------------ CHECK-FILES ----------------------------------
-- -----------------------------------------------------------------------------
-----   Verify settings files exist and create them if they don't exist    -----
-- -----------------------------------------------------------------------------

-- Check if the .leader file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.leader") ~= 1 then
  vim.fn.writefile({ vim.g.mapleader }, vim.fn.stdpath("config") .. "/.leader")
end

-- Check if the .colorscheme file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.colorscheme") ~= 1 then
  -- Use the kitty theme
  if os.getenv("KITTY_THEME") then
    KITTY_THEME = os.getenv("KITTY_THEME")
    vim.fn.writefile(
      { KITTY_THEME },
      vim.fn.stdpath("config") .. "/.colorscheme"
    )
  else
    -- Use the default colorscheme
    vim.fn.writefile(
      { vim.g.colors_name },
      vim.fn.stdpath("config") .. "/.colorscheme"
    )
  end
end

-- Check if the .aitool file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.aitool") ~= 1 then
  vim.fn.writefile({ "codeium" }, vim.fn.stdpath("config") .. "/.aitool")
end

-- Check if the .useimage file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.useimage") ~= 1 then
  vim.fn.writefile({ "true" }, vim.fn.stdpath("config") .. "/.useimage")
end

-- Check if the .wakatime file exists
if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.wakatime") ~= 1 then
  vim.fn.writefile({ "true" }, vim.fn.stdpath("config") .. "/.wakatime")
end
