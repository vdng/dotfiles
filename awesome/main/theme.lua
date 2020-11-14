-- Standard awesome libraries
local gears     = require("gears")
local awful     = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local home = os.getenv("HOME")

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(home .. "/.config/awesome/themes/vdng_lighthaus/theme.lua")
