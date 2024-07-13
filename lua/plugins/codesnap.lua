-- -----------------------------------------------------------------------------
-- -------------------------------- CodeSnap -----------------------------------
-- -----------------------------------------------------------------------------
return {
  "mistricky/codesnap.nvim",
  build = "make",
  opts = {
    save_path = "~/Pictures/Screenshots/",
    has_breadcrumbs = true,
    show_workspace = true,
    bg_theme = "default",
    watermark = "Rootiest Snippets",
    code_font_family = "Iosevka NF",
    code_font_size = 12,
  },
}
