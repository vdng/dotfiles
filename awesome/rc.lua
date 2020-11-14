------------------------------------------------
--                  LIBRARIES                 --
------------------------------------------------

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- global namespace, on top before require any modules
RC = {}

-- User variables
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- Error handling
require("main.error-handling")

-- Theme
require("main.theme")
require("deco.statusbar")

-- Signals

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  rules   = require("main.rules"),
}
require("main.signals")

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}

------------------------------------------------
--                   GENERAL                  --
------------------------------------------------

-- Layouts
RC.layouts = main.layouts()
awful.layout.layouts = main.layouts()

-- Tags
RC.tags = main.tags()

-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()


-- Rules
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)

------------------------------------------------
--                  STARTUP                   --
------------------------------------------------

-- Screen saver
awful.util.spawn_with_shell("xscreensaver -no-splash")

-- Compositor
awful.util.spawn_with_shell("compton")

-- Touchpad settings
awful.util.spawn_with_shell("xinput set-prop 'MSFT0001:00 06CB:CD3E Touchpad' 'libinput Accel Speed' 0.5")
awful.util.spawn_with_shell("xinput set-prop 'MSFT0001:00 06CB:CD3E Touchpad' 'libinput Middel Emulation Enabled' 1")
awful.util.spawn_with_shell("xinput set-prop 'MSFT0001:00 06CB:CD3E Touchpad' 'libinput Natural Scrolling Enabled' 1")
awful.util.spawn_with_shell("xinput set-prop 'MSFT0001:00 06CB:CD3E Touchpad' 'libinput Tapping Enabled' 1")

-- Keyboard settings
awful.util.spawn_with_shell("xset r rate 150 20")

-- Load display
awful.util.spawn_with_shell("autorandr -c")
