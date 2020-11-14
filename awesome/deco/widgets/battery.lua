local wibox       = require("wibox")
local lain        = require("lain")
local markup      = lain.util.markup
local xresources  = require("beautiful.xresources")
local colorscheme = xresources.get_current_theme()
local dpi         = xresources.apply_dpi

W.battery = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    {
      id     = 'icon',
      widget = wibox.widget.imagebox
    },
    id     = 'icon_margins',
    widget = wibox.container.margin,
    left   = dpi(8),
    right  = dpi(8)
  },
  {
    {
      id     = 'text',
      widget = wibox.widget.textbox
    },
    id     = 'text_margins',
    widget = wibox.container.margin,
    left   = dpi(0),
    right  = dpi(0)
  }
}

local bat = lain.widget.bat({
  settings = function ()
    if bat_now.status and bat_now.perc and bat_now.status ~= "N/A" then

      if bat_now.status == "Full" then
        W.battery.icon_margins.icon:set_image(theme.power_plug)
        W.battery.text_margins.text.markup = ''
        W.battery.icon_margins.right       = dpi(8)
        W.battery.text_margins.left        = dpi(0)
        W.battery.text_margins.right       = dpi(0)
        return
      end

      W.battery.icon_margins.right = dpi(0)
      W.battery.text_margins.left  = dpi(6)
      W.battery.text_margins.right = dpi(8)

      W.battery.text_margins.text.markup = markup.fontfg(theme.font, theme.topright_widgets_fg, bat_now.perc)

      if bat_now.status == "Charging" then
        if     tonumber(bat_now.perc) <= 10 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_10)
          return
        elseif tonumber(bat_now.perc) <= 20 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_20)
          return
        elseif tonumber(bat_now.perc) <= 30 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_30)
          return
        elseif tonumber(bat_now.perc) <= 40 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_40)
          return
        elseif tonumber(bat_now.perc) <= 50 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_50)
          return
        elseif tonumber(bat_now.perc) <= 60 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_60)
          return
        elseif tonumber(bat_now.perc) <= 70 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_70)
          return
        elseif tonumber(bat_now.perc) <= 80 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_80)
          return
        elseif tonumber(bat_now.perc) <= 90 then
          W.battery.icon_margins.icon:set_image(theme.battery_charging_90)
          return
        else
          W.battery.icon_margins.icon:set_image(theme.battery_charging_100)
          return
        end
      else--if bat_now.status == "Discharging" then
        if     tonumber(bat_now.perc) <= 10 then
          W.battery.icon_margins.icon:set_image(theme.battery_10)
          return
        elseif tonumber(bat_now.perc) <= 20 then
          W.battery.icon_margins.icon:set_image(theme.battery_20)
          return
        elseif tonumber(bat_now.perc) <= 30 then
          W.battery.icon_margins.icon:set_image(theme.battery_30)
          return
        elseif tonumber(bat_now.perc) <= 40 then
          W.battery.icon_margins.icon:set_image(theme.battery_40)
          return
        elseif tonumber(bat_now.perc) <= 50 then
          W.battery.icon_margins.icon:set_image(theme.battery_50)
          return
        elseif tonumber(bat_now.perc) <= 60 then
          W.battery.icon_margins.icon:set_image(theme.battery_60)
          return
        elseif tonumber(bat_now.perc) <= 70 then
          W.battery.icon_margins.icon:set_image(theme.battery_70)
          return
        elseif tonumber(bat_now.perc) <= 80 then
          W.battery.icon_margins.icon:set_image(theme.battery_80)
          return
        elseif tonumber(bat_now.perc) <= 90 then
          W.battery.icon_margins.icon:set_image(theme.battery_90)
          return
        else
          W.battery.icon_margins.icon:set_image(theme.battery)
          return
        end
      end
    else
      W.battery.icon_margins.icon:set_image(theme.battery_unknown)
      W.battery.text_margins.text.markup = ''
      W.battery.icon_margins.right       = dpi(8)
      W.battery.text_margins.left        = dpi(0)
      W.battery.text_margins.right       = dpi(0)
      return
    end
  end
})

