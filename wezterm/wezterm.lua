local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_workspace = "home"
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

-- config.default_gui_startup_args = { 'start', '--always-new-process'}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

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

config.unix_domains = {
  { name = 'unix',
  }, }

-- uncomment to autoconnect to unix domain
-- config.default_gui_startup_args = {'connect', 'unix'}

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save()

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
  local workspace_state = resurrect.workspace_state
  workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
    window = window,
    relative = true,
    restore_text = true,
    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  })
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
  local workspace_state = resurrect.workspace_state
  resurrect.save_state(workspace_state.get_workspace_state())
end)

-- local session_manager = require 'wezterm-session-manager/session-manager'
wezterm.on("update-right-status", function(window)
  window:set_right_status(window:active_workspace())
end)

return config
