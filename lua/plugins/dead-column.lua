-- -----------------------------------------------------------------------------
-- ------------------------------- DeadColumn ----------------------------------
-- -----------------------------------------------------------------------------
return {
  "Bekaboo/deadcolumn.nvim",
  config = function()
    require("deadcolumn").setup({
      scope = "line", ---@type string|fun(): integer
      ---@type string[]|fun(mode: string): boolean
      modes = function(mode)
        return mode:find("^[ictRss\x13]") ~= nil
      end,
      blending = {
        threshold = 0.9,
        colorcode = "#737895",
        hlgroup = { "Normal", "bg" },
      },
      warning = {
        alpha = 0.4,
        offset = 0,
        colorcode = "#f27b82",
        hlgroup = { "Error", "bg" },
      },
      extra = {
        ---@type string?
        follow_tw = "80",
      },
    })
    vim.cmd(":set colorcolumn=120")
  end,
}

