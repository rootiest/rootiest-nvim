-- -----------------------------------------------------------------------------
-- ------------------------------- Catppuccin ----------------------------------
-- -----------------------------------------------------------------------------
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        diffview = true,
        dashboard = true,
        gitsigns = true,
        nvimtree = true,
        neotree = true,
        treesitter = true,
        markdown = true,
        sandwich = true,
        which_key = true,
        telescope = { enabled = true, style = "nvchad" },
        illuminate = { enabled = true, lsp = true },
        notify = true,
        notifier = true,
        dap = true,
        dap_ui = true,
        ts_rainbow2 = true,
        rainbow_delimiters = true,
        lsp_trouble = true,
        noice = true, -- codespell:ignore noice
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = { background = true },
        },
        mini = { enabled = true, indentscope_color = "mauve" },
      },
    })
  end,
}