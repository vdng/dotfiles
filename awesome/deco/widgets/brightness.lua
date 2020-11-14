-------------------------------------------------
-- Brightness Widget for Awesome Window Manager
-- Shows the brightness level of the laptop display
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/brightness-widget

-- @author Pavel Makhov
-- @copyright 2017-2019 Pavel Makhov
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local lain  = require("lain")
local markup = require("lain").util.markup

-- Xresources
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi

local GET_BRIGHTNESS_CMD = "xbacklight -get"
local INC_BRIGHTNESS_CMD = "xbacklight -inc 5 -fps 60"
local DEC_BRIGHTNESS_CMD = "xbacklight -dec 5 -fps 60"

local args = args or {}
local get_brightness_cmd = args.get_brightness_cmd or GET_BRIGHTNESS_CMD
local inc_brightness_cmd = args.inc_brightness_cmd or INC_BRIGHTNESS_CMD
local dec_brightness_cmd = args.dec_brightness_cmd or DEC_BRIGHTNESS_CMD
local timeout = args.timeout or 1

W.brightness = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    {
      id = 'icon',
      widget = wibox.widget.imagebox
    },
    id = 'icon_margins',
    widget = wibox.container.margin,
    left = dpi(8),
    right = dpi(6)
  },
  {
    {
      id = 'text',
      widget = wibox.widget.textbox
    },
    id = 'text_margins',
    widget = wibox.container.margin,
    left = dpi(0),
    right = dpi(8)
  }
}

local update_widget = function(widget, stdout, _, _, _)
  local brightness_level = tonumber(string.format("%.0f", stdout))
  widget:set_markup(markup.fontfg(theme.font, theme.topright_widgets_fg, brightness_level))
  if brightness_level <= 20 then
    W.brightness.icon_margins.icon:set_image(theme.brightness_5)
  elseif brightness_level <= 80 then
    W.brightness.icon_margins.icon:set_image(theme.brightness_6)
  else
    W.brightness.icon_margins.icon:set_image(theme.brightness_7)
  end
end,

W.brightness:connect_signal("button::press", function(_, _, _, button)
  if (button == 4) then
    spawn(inc_brightness_cmd, false)
  elseif (button == 5) then
    spawn(dec_brightness_cmd, false)
  end
end)

watch(get_brightness_cmd, timeout, update_widget, W.brightness.text_margins.text)

