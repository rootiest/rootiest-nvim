-- -----------------------------------------------------------------------------
-- --------------------------------- NEOVIDE -----------------------------------
-- -----------------------------------------------------------------------------

-- Set GUI font
vim.opt.guifont = "Iosevka:#e-subpixelantialias:h12"
-- refresh rate and translucency
vim.g.neovide_refresh_rate = 170
vim.g.neovide_transparency = 0.85
vim.g.neovide_window_blurred = true
-- cursor fx
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_vfx_particle_density = 16.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.6
vim.g.neovide_cursor_vfx_particle_phase = 1.2
vim.g.neovide_cursor_vfx_particle_curl = 1.0
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
-- floating shadow
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
-- scaling
vim.g.neovide_scale_factor = 1.0
-- padding
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

-- Simulate kitty copy-and-paste from system clipboard
-- in normal mode
vim.cmd(":nnoremap <silent> <C-v> :r !xsel -b<cr>")
vim.cmd(":nnoremap <silent> <C-c> :w !xsel -i -b<cr>")
-- and in visual mode
vim.cmd(":vnoremap <silent> <C-v> :r !xsel -b<cr>")
vim.cmd(":vnoremap <silent> <C-c> :w !xsel -i -b<cr>")
-- and in command mode
vim.cmd(":cnoremap <silent> <C-v> <C-r>+")
vim.cmd(":cnoremap <silent> <C-c> <C-r>+")
-- and in insert mode
vim.cmd(":inoremap <silent> <C-v> <C-r>+")
vim.cmd(":inoremap <silent> <C-c> <C-r>+")
