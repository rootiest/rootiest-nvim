--          ╭─────────────────────────────────────────────────────────╮
--          │                          Debug                          │
--          ╰─────────────────────────────────────────────────────────╯
return {
  { -- DAP Core
    import = "lazyvim.plugins.extras.dap.core",
  },
  { -- DAP Neovim Lua Adapter
    import = "lazyvim.plugins.extras.dap.nlua",
  },
}
