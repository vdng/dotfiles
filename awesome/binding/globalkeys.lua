-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")

-- Cyclefocus widget
local cyclefocus = require("cyclefocus")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local globalkeys = gears.table.join(

    awful.key({ modkey,           }, "à",
              hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Tag browsing
    awful.key({ modkey,           }, "Left",
              function()
                local screen = awful.screen.focused()
                awful.tag.viewprev(screen)
                client.focus = awful.client.focus.history.get(screen, 0)
              end,
              {description = "view previous", group = "tag"}),

    awful.key({ modkey,           }, "Right",
              function()
                local screen = awful.screen.focused()
                awful.tag.viewnext(screen)
                client.focus = awful.client.focus.history.get(screen, 0)
              end,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "Escape",
              function()
                local screen = awful.screen.focused()
                awful.tag.history.restore(screen)
                client.focus = awful.client.focus.history.get(screen, 0)
              end,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "t",
              function () awful.client.focus.byidx( 1)    end,
              {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "s",
              function () awful.client.focus.byidx(-1)    end,
              {description = "focus previous by index", group = "client"}
    ),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "t",
              function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "s",
              function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "t",
              function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "s",
              function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey,           }, "u",
              awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Cyclefocus widget
    -- modkey+Tab: cycle through all clients.
    awful.key({ modkey,         }, "Tab",
              function(c) cyclefocus.cycle({modifier="Super_L"}) end),

    -- modkey+Shift+Tab: backwards
    awful.key({ modkey, "Shift" }, "Tab",
              function(c) cyclefocus.cycle({modifier="Super_L"}) end),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Standard program
    awful.key({ modkey,           }, "Return",
              function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, "Control" }, "h",
              awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "q",
              awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",
              function() awful.spawn("xscreensaver-command -lock") end,
              {description = "lock session", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey,           }, "r",
              function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey,           }, "c",
              function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "r",
              function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "c",
              function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey, "Control" }, "r",
              function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "c",
              function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space",
              function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space",
              function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Rofi
    awful.key({ modkey }, "h",
              function () os.execute("rofi -show run -terminal termite") end,
              {description = "Rofi run"   , group = "launcher"}),

    awful.key({ modkey }, "g",
              function () os.execute("rofi -show window") end,
              {description = "Rofi window", group = "launcher"}),

    awful.key({ modkey }, "p",
              function () os.execute("rofi -show drun -terminal termite") end,
              {description = "Rofi drun"   , group = "launcher"}),

    awful.key({ modkey }, "v",
              function () os.execute("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'") end,
              {description = "Rofi greenclip"   , group = "launcher"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Resize
    awful.key({ modkey, "Control" }, "Down" , function () awful.client.moveresize( 0, 0,   0,  40) end),
    awful.key({ modkey, "Control" }, "Up"   , function () awful.client.moveresize( 0, 0,   0, -40) end),
    awful.key({ modkey, "Control" }, "Left" , function () awful.client.moveresize( 0, 0, -40,   0) end),
    awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize( 0, 0,  40,   0) end),

    -- Move
    awful.key({ modkey, "Shift"   }, "Down" , function () awful.client.moveresize(  0,  40, 0, 0) end),
    awful.key({ modkey, "Shift"   }, "Up"   , function () awful.client.moveresize(  0, -40, 0, 0) end),
    awful.key({ modkey, "Shift"   }, "Left" , function () awful.client.moveresize(-40,   0, 0, 0) end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.moveresize( 40,   0, 0, 0) end),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Screenshots
    awful.key({                    }, "Print",
              function() os.execute("maim ~/tmp/screenshots/$(date +%s).png") end),

    awful.key({ "Control"          }, "Print",
              function() os.execute("maim | xclip -selection clipboard -t image/png") end),

    awful.key({ "Shift"            }, "Print",
              function() os.execute("maim -s ~/tmp/screenshots/$(date +%s).png") end),

    awful.key({ "Shift", "Control",}, "Print",
              function() os.execute("maim -s | xclip -selection clipboard -t image/png") end),

    awful.key({ "Mod1"             }, "Print",
              function() os.execute("maim -i $(xdotool getactivewindow) ~/tmp/screenshots/$(date +%s).png") end),

    awful.key({ "Mod1" , "Control" }, "Print",
              function() os.execute("maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png") end),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Audio volume
    awful.key({ }, "XF86AudioRaiseVolume",
              function()
                os.execute(string.format("pactl set-sink-volume %s +2%%", W.lain_volume.device))
                W.lain_volume.update()
              end),

    awful.key({ }, "XF86AudioLowerVolume",
              function()
                os.execute(string.format("pactl set-sink-volume %s -2%%", W.lain_volume.device))
                W.lain_volume.update()
              end),

    awful.key({ }, "XF86AudioMute",
              function()
                os.execute(string.format("pactl set-sink-mute %s toggle", W.lain_volume.device))
                W.lain_volume.update()
              end),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Brightness level
    awful.key({ }, "XF86MonBrightnessUp"  , function () awful.spawn("xbacklight -inc 5 -fps 60") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("xbacklight -dec 5 -fps 60") end)
  )

  return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
