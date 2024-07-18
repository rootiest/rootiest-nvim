package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path
  .. ";"
  .. vim.fn.expand("$HOME")
  .. "/.luarocks/share/lua/5.1/?.lua"

-- lazy snippet
return {
  "3rd/image.nvim",
  config = function()
    require("image").setup()
  end,
  cond = function()
    if vim.fn.filereadable(vim.fn.stdpath("config") .. "/.useimage") == 1 then
      if
        vim.fn.readfile(vim.fn.stdpath("config") .. "/.useimage")[1]
        == "true"
      then
        local term = os.getenv("TERM") or ""
        local kit = string.find(term, "kitty")
        return kit ~= nil
      end
    end
  end,
}
