-- -- Pull in the wezterm API
-- local wezterm = require 'wezterm'

-- -- This will hold the configuration.
-- local config = wezterm.config_builder()

-- -- This is where you actually apply your config choices

-- -- For example, changing the color scheme:
-- -- config.color_scheme = 'nord'
-- config.color_scheme = 'Batman'

-- -- Fonts:
-- config.font = wezterm.font 'D2CodingLigature Nerd Font'
-- config.font_size = 10

-- config.font = wezterm.font_with_fallback {
--   'Fira Code',
--   'DengXian',
-- }

-- -- and finally, return the configuration to wezterm
-- return config

local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
local ERROR_ICON = wezterm.nerdfonts.seti_error

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/bin/nu', '-l' }

config.default_workspace = 'workspace'
config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font_with_fallback {
  'D2CodingLigature',
  'Inconsolata Nerd Font',
  'Jetbrains Mono',
}
config.font_size = 10
config.cell_width = 0.9

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.inactive_pane_hsb = {
  saturation = 0.75,
  brightness = 0.55,
}
config.initial_cols = 168
config.initial_rows = 42

config.hide_tab_bar_if_only_one_tab = false
config.quit_when_all_windows_are_closed = false
config.use_fancy_tab_bar = false

config.show_update_window = true

config.window_decorations = 'RESIZE'

config.leader = { key = 'a', mods = 'CTRL', timeout_miliseconds = 1000 }
config.keys = {
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },
  { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'phys:Space', mods = 'LEADER', action = act.ActivateCommandPalette },

  -- pane keybindings
  { key = 's', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'o', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

  -- tab keybindings
  { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'n', mods = 'LEADER', action = act.ShowTabNavigator },
  {
    key = 'e',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Renaming Tab Title...' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- Key table for moving tabs around
  { key = 'm', mods = 'LEADER', action = act.ActivateKeyTable { name = 'move_tab', one_shot = false } },
  -- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
  { key = '{', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(1) },
}

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
  move_tab = {
    { key = 'h', action = act.MoveTabRelative(-1) },
    { key = 'j', action = act.MoveTabRelative(-1) },
    { key = 'k', action = act.MoveTabRelative(1) },
    { key = 'l', action = act.MoveTabRelative(1) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}
wezterm.on('update-status', function(window, pane)
  -- workspace name
  local stat = window:active_workspace()
  local stat_color = '#EEE8D5'

  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = '#676767'
  end

  if window:leader_is_active() then
    stat = 'LDR'
    stat_color = '#FFE8D5'
  end

  local time = wezterm.strftime '%H:%M'

  local cwd = pane:get_current_working_dir() or ERROR_ICON
  local cwd_rx = '(.*://' .. wezterm.hostname() .. wezterm.home_dir .. ')/(.*)'
  cwd = string.gsub(cwd, cwd_rx, '%2')

  local cmd = pane:get_foreground_process_name() or ERROR_ICON
  local cmd_rx = '(.*/)(.*)'
  cmd = string.gsub(cmd, cmd_rx, '%2')

  window:set_left_status(wezterm.format {
    { Foreground = { Color = stat_color } },
    { Text = ' ' },
    { Text = wezterm.nerdfonts.oct_table .. '  ' .. stat },
    { Text = ' |' },
  })

  window:set_right_status(wezterm.format {
    { Text = ' ' },
    { Text = wezterm.nerdfonts.md_folder .. '  ' .. cwd },
    { Text = ' | ' },
    { Text = wezterm.nerdfonts.md_application .. '  ' .. cmd },
    'ResetAttributes',
    { Text = ' | ' },
    { Text = wezterm.nerdfonts.md_clock .. ' ' .. time },
    { Text = ' ' },
  })
end)

-- DEBGUG MUX TAB SIZE
-- wezterm.on('window-resized', function(window, pane)
--   local size = pane:tab():get_size()
--   wezterm.log_warn('tab: ' .. tostring(size.cols) .. 'x' .. tostring(size.rows))
-- end)

return config
