local wezterm = require 'wezterm'

return {
  enable_wayland = true,
	color_scheme = 'Catppuccin Mocha',
	-- color_scheme = 'Batman',
	font = wezterm.font "Fira Code",
  font_size = 10.0,
	default_cursor_style = "BlinkingBar",
	window_close_confirmation = "NeverPrompt",

	window_decorations = "NONE";
	window_padding = {
		top = "0",
		right = "0",
		bottom = "0",
		left = "0",
	},

unix_domains = {
	
},

use_fancy_tab_bar = false,
tab_bar_at_bottom = true,
hide_tab_bar_if_only_one_tab = true,

colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  }
},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	window_background_opacity = 1.0,
	text_background_opacity = 1.0,

	keys = require("keys"),
}
