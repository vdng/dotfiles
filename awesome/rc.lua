--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
--local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility

-- }}}

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        }

        in_error = false
    end)
end

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "picom --experimental-backends", "greenclip", "autorandr -c", "unclutter", "udiskie", "redshift-gtk" }) -- comma-separated entries

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local themes = {
    "powerarrow-dark", -- 1
    "lighthaus",       -- 2
    "dracula",         -- 3
}

local chosen_theme = themes[3]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "alacritty"
local vi_focus     = true -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local editor       = os.getenv("EDITOR") or "nvim"
local browser      = "qutebrowser"

awful.util.terminal = terminal
awful.layout.layouts = {
    --awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    lain.layout.termfair.center
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

awful.util.tagnames = { "", "", "", "", "", "", "", "ﱘ", "" }
local l = awful.layout.suit
awful.util.layouts = { l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, lain.layout.termfair.center }

awful.util.taglist_buttons = mytable.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = mytable.join(
     awful.button({ }, 1, function(c)
         if c == client.focus then
             c.minimized = true
         else
             c:emit_signal("request::activate", "tasklist", { raise = true })
         end
     end),
     awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
     end),
     awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- }}}

-- {{{ Menu

-- Create a launcher widget and a main menu
--local myawesomemenu = {
--   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--   { "Manual", string.format("%s -e man awesome", terminal) },
--   { "Edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
--   { "Restart", awesome.restart },
--   { "Quit", function() awesome.quit() end },
--}

--local mymainmenu = freedesktop.menu.build {
--    before = {
--        { "Awesome", myawesomemenu, beautiful.awesome_icon },
--        -- other triads can be put here
--    },
--    after = {
--        { "Open terminal", terminal },
--        -- other triads can be put here
--    }
--}

-- hide menu when mouse leaves it
--mymainmenu.wibox:connect_signal("mouse::leave", function() mymainmenu:hide() end)

-- Set the Menubar terminal for applications that require it
--menubar.utils.terminal = terminal

-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}

-- {{{ Mouse bindings

root.buttons(mytable.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- }}}

-- {{{ Key bindings

globalkeys = mytable.join(

    -- Focus screen
    awful.key({ modkey,           }, "w", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    -- Cycle layouts
    awful.key({ modkey,           }, "z", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Focus client by index
    awful.key({ modkey,           }, "Tab", function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

    -- Rofi
    awful.key({ modkey            }, "a", function () os.execute("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'") end,
              {description = "Rofi greenclip"   , group = "launcher"}),
    awful.key({ modkey            }, "u", function () os.execute("rofi -show run -terminal termite") end,
              {description = "Rofi run"   , group = "launcher"}),
    awful.key({ modkey            }, "e", function () os.execute("rofi -show drun -terminal termite") end,
              {description = "Rofi drun"   , group = "launcher"}),
    awful.key({ modkey            }, "/", function () os.execute("rofi -show window") end,
              {description = "Rofi window", group = "launcher"}),

    -- By-direction client focus
    awful.key({ modkey }, "t", function() awful.client.focus.global_bydirection("down") if client.focus then client.focus:raise() end end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "s", function() awful.client.focus.global_bydirection("up") if client.focus then client.focus:raise() end end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "c", function() awful.client.focus.global_bydirection("left") if client.focus then client.focus:raise() end end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "r", function() awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end,
        {description = "focus right", group = "client"}),

    -- Master width
    awful.key({ modkey, "Control"   }, "r",     function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control"   }, "c",     function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Control"   }, "z",     function () awful.tag.incnmaster( 1) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control"   }, "j",     function () awful.tag.incnmaster(-1) end,
              {description = "decrease the number of master clients", group = "layout"}),

    -- Show help
    awful.key({ modkey,           }, "'",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Toggle systray visibility
    awful.key({ modkey, "Control" }, "e", function() awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible end,
              {description = "toggle systray visibility", group = "screen"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.global_bydirection("down") end,
              {description = "swap down", group = "client"}),
    awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.global_bydirection("up") end,
              {description = "swap up", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c", function () awful.client.swap.global_bydirection("left") end,
              {description = "swap left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "r", function () awful.client.swap.global_bydirection("right") end,
              {description = "swap right", group = "client"}),

    awful.key({ modkey,           }, "g", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    -- Restart awesome
    awful.key({ modkey, "Control" }, "w", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Shift" }, "h", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end, {description = "restore minimized", group = "client"}),

    -- Screenshots
    awful.key({                   }, "Print", function() os.execute("maim ~/tmp/screenshots/$(date +%s).png") end,
              {description = "Capture all to tmp"   , group = "screenshots"}),
    awful.key({ "Control"         }, "Print", function() os.execute("maim | xclip -selection clipboard -t image/png") end,
              {description = "Capture all to clipboard"   , group = "screenshots"}),
    awful.key({ "Shift"           }, "Print", function() os.execute("maim -s ~/tmp/screenshots/$(date +%s).png") end,
              {description = "Capture selection to tmp"   , group = "screenshots"}),
    awful.key({ "Shift", "Control"}, "Print", function() os.execute("maim -s | xclip -selection clipboard -t image/png") end,
              {description = "Capture selection to clipboard"   , group = "screenshots"}),
    awful.key({ altkey            }, "Print", function() os.execute("maim -i $(xdotool getactivewindow) ~/tmp/screenshots/$(date +%s).png") end,
              {description = "Capture window to tmp"   , group = "screenshots"}),
    awful.key({ altkey, "Control" }, "Print", function() os.execute("maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png") end,
              {description = "Capture window to clipboard"   , group = "screenshots"}),

    -- On-the-fly useless gaps change
    awful.key({ modkey, "Control" }, "s", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ modkey, "Control" }, "t", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Screen brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 5 -fps 60") end,
              {description = "brightness up%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 5 -fps 60") end,
              {description = "brighness down", group = "hotkeys"}),
    awful.key({ modkey }, "XF86MonBrightnessUp", function () os.execute("pkill -USR1 '^redshift$'") end,
              {description = "toggle redshift", group = "hotkeys"}),

    -- Audio volume
    awful.key({ }, "XF86AudioRaiseVolume", function() os.execute(string.format("pactl set-sink-volume %s +2%%", beautiful.volume.device)) beautiful.volume.update() end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function() os.execute(string.format("pactl set-sink-volume %s -2%%", beautiful.volume.device)) beautiful.volume.update() end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute", function() os.execute(string.format("pactl set-sink-mute %s toggle", beautiful.volume.device)) beautiful.volume.update() end,
        {description = "mute", group = "hotkeys"}),

    -- Media control
    awful.key({ }, "XF86AudioPlay", function() os.execute("playerctl play-pause") end,
        {description = "play/pause", group = "hotkeys"}),
    awful.key({ }, "XF86AudioPrev", function() os.execute("playerctl previous") end,
        {description = "play/pause", group = "hotkeys"}),
    awful.key({ }, "XF86AudioNext", function() os.execute("playerctl next") end,
        {description = "play/pause", group = "hotkeys"})
)

clientkeys = mytable.join(
    awful.key({ modkey,           }, "m", function (c) c.maximized = not c.maximized c:raise() end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey,           }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,           }, "n",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Shift"   }, "n", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "ç",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "h", function (c) c.minimized = true end ,
        {description = "minimize", group = "client"})
)

-- Bind first row to tags using keycodes
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 23,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 23,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 23,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 23,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = mytable.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
          "keepassxc",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Remove titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = mytable.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 16 }) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}
