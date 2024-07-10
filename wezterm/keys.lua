local wezterm = require("wezterm")
local wa = wezterm.action

wezterm.on("toggle-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.8
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

return {
  { key = "o", mods = "CTRL", action = wa.EmitEvent("toggle-opacity") },
  {
      key = '`',
      mods = 'CTRL|SHIFT',
      action = wa.SplitPane {
          direction = 'Down',
      --   command = { args = { 'top' } },
          size = { Percent = 30 },
      },
  },
  { key = 'n', mods = 'ALT', action = wa.SplitPane {
    direction = 'Right',
    -- size = {Percent = 50 },
  }, },
  {
      key = '/',
      mods = 'CTRL|SHIFT',
      action = wa.SplitPane {
          direction = 'Right',
      --   command = { args = { 'top' } },
          size = { Percent = 50 },
      },
  },
  {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wa.CloseCurrentPane {confirm = true },
  },
  {
      key = 'w',
      mods = 'CTRL|SHIFT|ALT',
      action = wa.CloseCurrentTab {confirm = true },
  },

  -- { key = '[', mods = 'CTRL|SHIFT', action = wa.ActivatePaneDirection 'Prev' },
  -- { key = ']', mods = 'CTRL|SHIFT', action = wa.ActivatePaneDirection 'Next' },
  { key = 'P', mods = 'CTRL', action = wezterm.action.ShowLauncher },

  { key = 'l', mods = 'ALT', action = wa.ActivatePaneDirection 'Left' },
}
