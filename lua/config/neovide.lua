--- @module "config.neovide"
--- This module defines the neovide options for the Neovim configuration.
--          ╭─────────────────────────────────────────────────────────╮
--          │                         Neovide                         │
--          ╰─────────────────────────────────────────────────────────╯
-- Set GUI font
vim.opt.guifont = "Iosevka Rootiest V2:#e-subpixelantialias:h12"
-- refresh rate and translucency
vim.g.neovide_refresh_rate = 120
vim.g.neovide_transparency = 0.85
vim.g.neovide_window_blurred = true
-- cursor fx
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_vfx_particle_density = 16.0
vim.g.neovide_cursor_vfx_particle_lifetime = 2.1
vim.g.neovide_cursor_vfx_particle_phase = 1.2
vim.g.neovide_cursor_vfx_particle_curl = 1.0
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
-- floating shadow
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
-- scaling
vim.g.neovide_scale_factor = 1.0
-- padding
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

-- Simulate kitty copy-and-paste from system clipboard

-- Normal mode
vim.keymap.set("n", "<C-v>", ":r !xsel -b<CR>", { silent = true })
vim.keymap.set("n", "<C-c>", ":w !xsel -i -b<CR>", { silent = true })

-- Visual mode
vim.keymap.set("v", "<C-v>", ":r !xsel -b<CR>", { silent = true })
vim.keymap.set("v", "<C-c>", ":w !xsel -i -b<CR>", { silent = true })

-- Command mode
vim.keymap.set("c", "<C-v>", "<C-r>+", { silent = true })
vim.keymap.set("c", "<C-c>", "<C-r>+", { silent = true })

-- Insert mode
vim.keymap.set("i", "<C-v>", "<C-r>+", { silent = true })
vim.keymap.set("i", "<C-c>", "<C-r>+", { silent = true })
