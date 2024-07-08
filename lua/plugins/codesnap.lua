-- -----------------------------------------------------------------------------
-- -------------------------------- CodeSnap -----------------------------------
-- -----------------------------------------------------------------------------
return {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      {
        "<leader>cy",
        "<cmd>CodeSnap<cr>",
        mode = "x",
        desc = "󰹑 Save selected code snapshot into clipboard",
      },
      {
        "<leader>cs",
        "<cmd>CodeSnapSave<cr>",
        mode = "x",
        desc = "󰉏 Save selected code snapshot in ~/Pictures",
      },
      {
        "<leader>ch",
        "<cmd>CodeSnapHighlight<cr>",
        mode = "x",
        desc = " Highlight and snapshot selected code into clipboard",
      },
      {
        "<leader>ci",
        "<cmd>CodeSnapASCII<cr>",
        mode = "x",
        desc = " Save ASCII code snapshot into clipboard",
      },
    },
    opts = {
      save_path = "~/Pictures/Screenshots/",
      has_breadcrumbs = true,
      show_workspace = true,
      --has_line_number = true,
      bg_theme = "default",
      watermark = "Rootiest Snippets",
      code_font_family = "CaskaydiaCove NF",
      code_font_size = 12,
    },
}