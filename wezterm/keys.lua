local wezterm = require("wezterm")
local projects = require 'projects'
local wa = wezterm.action
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

wezterm.on("toggle-opacity", function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.8
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

local function is_paned(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  -- return pane:get_user_vars().ZELLIJ == 0
  if pane:get_user_vars().ZELLIJ == '0' then
    return true
  end
  if pane:get_foreground_process_name() == '/usr/lib/helix' then
  	return true
	end
  return false
end

local direction_keys = {
  Left = 'h',
  Down = 'j',
  Up = 'k',
  Right = 'l',
  -- reverse lookup
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'CTRL|ALT' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_paned(pane) then
        -- pass the keys through
        win:perform_action({
          SendKey = { key = 'w', mods = resize_or_move == 'resize' and 'CTRL|ALT' or 'CTRL' },
        }, pane)
        win:perform_action({
          SendKey = { key = key, --[[ mods = resize_or_move == 'resize' and 'META' or 'CTRL' --]] },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function yazi_pane(key)
  return {
    key = key,
    mods = 'CTRL',
    action = wezterm.action_callback(function(_, pane)
      local proc = pane:get_foreground_process_name()
      if proc ~= '/usr/bin/yazi' then
        local dir = pane:get_current_working_dir().file_path
        pane:split {
          direction = 'Left',
          size =  .25,
          args = {'yazi', dir},
          set_environment_variables = {
            YAZI_CONFIG_HOME = '~/.config/yazi/filetree',
          },
        }
      end
    end)
  }
end

return {
  -- Clashes with common editor keybinds
  -- { key = "o", mods = "CTRL", action = wa.EmitEvent("toggle-opacity") },
  --[[ { key = 'n', mods = 'ALT', action = wa.SplitPane {
    direction = 'Right',
    -- size = {Percent = 50 },
  }, }, --]]
  { key = 'q', mods = 'LEADER', action = wa.CloseCurrentPane { confirm = false } },
  { key = 'Q', mods = 'LEADER', action = wa.CloseCurrentTab { confirm = true } },
  { key = 'n', mods = 'LEADER', action = wa.SpawnTab 'CurrentPaneDomain' },
  -- { key = "s", mods = "LEADER", action = wa({ EmitEvent = "save_session" }) },
  -- { key = "l", mods = "LEADER", action = wa({ EmitEvent = "load_session" }) },
  -- { key = "R", mods = "LEADER|SHIFT", action = wa({ EmitEvent = "restore_session" }) },
  {
    key    = "v",
    mods   = "LEADER",
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    key    = "h",
    mods   = "LEADER",
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  { key = 'm', mods = 'LEADER', action = wa.TogglePaneZoomState },
  {
    mods = "LEADER",
    key = "Space",
    action = wezterm.action.RotatePanes "Clockwise"
  },
  -- show the pane selection mode, but have it swap the active and selected panes
  {
    mods = 'LEADER',
    key = '0',
    action = wezterm.action.PaneSelect {
      mode = 'SwapWithActive',
    },
  },
  { key = 'l', mods = 'ALT',    action = wa.ActivatePaneDirection 'Left' },
  -- move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
  {
    key = 'Enter',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode
  },
  {
    key = 'g',
    mods = 'LEADER',
    action = wa.SplitPane {
      direction = 'Left',
      command = {
        args = { 'lazygit' },
      },
    },
  },
  -- Yazi integration
  yazi_pane('f'),
  --[[ {
    key = 'a',
    mods = 'LEADER',
    action = wa.AttachDomain 'unix',
  },

  -- Detach from muxer
  {
    key = 'd',
    mods = 'LEADER',
    action = wa.DetachDomain { DomainName = 'unix' },
  }, --]]
 {
    key = 'r',
    mods = 'LEADER',
    action = wa.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  {
    key = "w",
    mods = "ALT",
    action = workspace_switcher.switch_workspace(),
  },
  {
    key = "t",
    mods = "LEADER",
    action = workspace_switcher.switch_to_prev_workspace(),
  },
  {
    key = 'b',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  { key = 'p', mods = 'LEADER', action = projects.choose_project(), },
}
