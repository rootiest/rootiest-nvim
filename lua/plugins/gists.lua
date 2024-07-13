-- -----------------------------------------------------------------------------
-- ---------------------------------- Gists ------------------------------------
-- -----------------------------------------------------------------------------
return {
  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true,
  },
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
}
