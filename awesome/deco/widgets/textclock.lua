local wibox = require("wibox")
local lain = require("lain")
local markup = lain.util.markup
local xresources = require("beautiful.xresources")
local dpi   = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()

local calendar_icon = wibox.widget.imagebox(theme.calendar_icon)
local clock_icon    = wibox.widget.imagebox(theme.clock_icon)

local date = wibox.widget.textclock(
  markup.fontfg(theme.font, theme.bg_normal, "%a %d %b")
)

local clock = wibox.widget.textclock(
  markup.fontfg(theme.font, theme.bg_normal, "%H:%M")
)

W.textclock = wibox.layout.fixed.horizontal(
  wibox.container.margin(calendar_icon, dpi(25), dpi(0)),
  wibox.container.margin(date, dpi(6), dpi(10)),
  wibox.container.margin(clock_icon, dpi(10), dpi(0)),
  wibox.container.margin(clock, dpi(6), dpi(25))
)

theme.cal = lain.widget.cal({
  attach_to = { W.textclock },
  followtag = true,
  icons = "",
  notification_preset = {
    bg = theme.textclock_bg,
    fg = theme.bg_normal,
    position = "bottom_middle",
    font = theme.font,
  }
})
