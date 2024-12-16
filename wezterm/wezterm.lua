local wezterm = require 'wezterm'

-- local session_manager = require 'wezterm-session-manager/session-manager'
-- wezterm.on("update-right-status", function(window, pane)
--   window:set_right_status(window:active_workspace())
-- end)
-- wezterm.on("save_session", function(window) session_manager.save_state(window) end)
-- wezterm.on("load_session", function(window) session_manager.load_state(window) end)
-- wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)

local config = wezterm.config_builder()

config.enable_wayland = true
config.color_scheme = 'Catppuccin Mocha'
-- color_scheme = 'Batman',
config.font = wezterm.font "Fira Code"
config.font_size = 10.0
config.default_cursor_style = "BlinkingBar"
config.window_close_confirmation = "NeverPrompt"

config.window_decorations = "NONE";
config.window_padding = {
  top = "0",
  right = "0",
  bottom = "0",
  left = "0",
}

unix_domains = {

}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  }
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1300 }
config.keys = require("keys")

return config
