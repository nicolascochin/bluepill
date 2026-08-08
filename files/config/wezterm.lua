local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font "FiraCode Nerd Font Mono"
config.window_background_opacity = 0.8

config.color_scheme = "Dracula"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

return config
