local wezterm = require 'wezterm'

local session_manager = require('wezterm-session-manager/session-manager')
wezterm.on("save_session", function(window) session_manager.save_state(window) end)
wezterm.on("load_session", function(window) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)

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

	leader = {key = 'a', mods='ALT', timeout_milliseconds = 1300},
	keys = require("keys"),
}
