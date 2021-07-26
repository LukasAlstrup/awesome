local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')
local globalKeys =
  awful.util.table.join(
  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'Help', group = 'Awesome'}),
  awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'Next', group = 'Workspaces'}),
  awful.key({modkey}, 's', awful.tag.viewnext, {description = 'Previous', group = 'Workspaces'}),
  awful.key({modkey},'d',function()awful.client.focus.byidx(1)end,{description = 'Next', group = 'Windows'}),
  awful.key({modkey},'a',function()awful.client.focus.byidx(-1)end,{description = 'Previous', group = 'Windows'}),
  awful.key({modkey},'r',function()awful.spawn('rofi -combi-modi window,drun -show combi -modi combi')end,{description = 'Main menu', group = 'Awesome'}),
  awful.key({modkey, 'Shift'},'r',function()awful.spawn('reboot')end,{description = 'Reboot', group = 'Awesome'),
  awful.key({modkey, 'Shift'},'s',function()awful.spawn('shutdown now')end,{description = 'Shutdown', group = 'Awesome'}),
  awful.key({modkey, 'Shift'},'l',function()_G.exit_screen_show()end,{description = 'Logout', group = 'Awesome'}),
  awful.key({altkey},'Tab',function()awful.client.focus.byidx(1)if _G.client.focus then _G.client.focus:raise() end end,{description = 'Next', group = 'Windows'}),
  awful.key({altkey, 'Shift'},'Tab',function()awful.client.focus.byidx(-1)if _G.client.focus then _G.client.focus:raise() end end,{description = 'Previous', group = 'Windows'}),
  awful.key({modkey},'l',function()awful.spawn(apps.default.lock)end,{description = 'Lock', group = 'Awesome'}),
  awful.key({modkey},'Print',function()awful.util.spawn_with_shell(apps.default.delayed_screenshot)end,{description = 'Mark, delay 10 sec and screenshot', group = 'Screenshot'}),
  awful.key({modkey},'p',function()awful.util.spawn_with_shell(apps.default.screenshot)end,{description = 'Screenshot active monitor', group = 'Screenshot'}),
  awful.key({altkey, 'Shift'},'p',function()awful.util.spawn_with_shell(apps.default.region_screenshot)end,{description = 'Mark and screenshot', group = 'Screenshot'}),
  awful.key({modkey},'c',function()awful.util.spawn(apps.default.editor)end,{description = 'Gedit', group = 'Programs'}),
  awful.key({modkey},'b',function()awful.util.spawn(apps.default.browser)end,{description = 'Brave', group = 'Programs'}),
  awful.key({modkey},'x',function()awful.spawn(apps.default.terminal)end,{description = 'Terminator', group = 'Programs'}),
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'Reload awesome', group = 'Awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'Quit awesome', group = 'Awesome'}),
  awful.key({altkey, 'Shift'},'Right',function()awful.tag.incmwfact(0.05)end,{description = 'Increase width', group = 'Layout'}),
  awful.key({altkey, 'Shift'},'Left',function()awful.tag.incmwfact(-0.05)end,{description = 'Decrease width', group = 'Layout'}),
  awful.key({altkey, 'Shift'},'Down',function()awful.client.incwfact(0.05)end,{description = 'Decrease height', group = 'Layout'}),
  awful.key({altkey, 'Shift'},'Up',function()awful.client.incwfact(-0.05)end,{description = 'Increase height', group = 'Layout'}),
  awful.key({modkey},'space',function()awful.layout.inc(1)end,{description = 'Select next', group = 'Layout'}),
  awful.key({modkey, 'Shift'},'space',function()awful.layout.inc(-1)end,{description = 'Previous', group = 'Layout'}),
  awful.key({modkey},'o',awful.client.movetoscreen,{description = 'Move', group = 'Windows'}),
  awful.key({modkey},'e',function()awful.util.spawn(apps.default.files)end,{description = 'Nemo', group = 'hotkeys'})
)

for i = 1, 9 do
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = 'view tag #', group = 'Workspaces'}
    descr_toggle = {description = 'toggle tag #', group = 'Workspaces'}
    descr_move = {description = 'move focused client to tag #', group = 'Workspaces'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'Workspaces'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    awful.key(
      {modkey},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view
    ),
    awful.key(
      {modkey, 'Control'},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle
    ),
    awful.key(
      {modkey, 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move
    ),
    awful.key(
      {modkey, 'Control', 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus
    )
  )
end

return globalKeys
