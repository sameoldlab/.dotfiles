return {
  entry = function()
    local h = cx.active.current.hovered

    if h.cha.is_dir then
      ya.manager_emit('enter' or 'open', { hovered = true })
    else
      -- Send ":" to start command input in Helix
      os.execute 'wezterm cli send-text --pane-id "$(wezterm cli get-pane-direction Right)" --no-paste ":"'

      -- Send the "open" command with file path(s) to the pane
      local file_path = tostring(h.url):gsub(" ", "\\ ")
      os.execute('wezterm cli send-text --pane-id "$(wezterm cli get-pane-direction Right)" "open ' .. file_path .. '"')

      -- Simulate 'Enter' key to execute the command
      os.execute 'printf "\r" | wezterm cli send-text --pane-id "$(wezterm cli get-pane-direction Right)" --no-paste'
    end
  end,
}
