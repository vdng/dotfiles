local lain = require("lain")
local wibox = require("wibox")
local awful = require("awful")

-- Xresources
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi

W.net = wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox(theme.wifi_settings)
  },
  widget = wibox.container.margin,
  left = dpi(8),
  right = dpi(8)
}

W.net.icon:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function ()
      awful.util.spawn_with_shell("connman-gtk")
    end
  )
))

local net = lain.widget.net {
  notify = "off",
  wifi_state = "on",
  settings = function()
    local wifi_device = net_now.devices['wlp110s0'] and net_now.devices['wlp110s0'] or net_now.devices['wlp115s0']
    if wifi_device then
      if wifi_device.wifi then
        local signal = wifi_device.signal
        if signal < -83 then
          W.net.icon:set_image(theme.wifi_weak)
        elseif signal < -70 then
          W.net.icon:set_image(theme.wifi_mid)
        elseif signal < -53 then
          W.net.icon:set_image(theme.wifi_good)
        elseif signal >= -53 then
          W.net.icon:set_image(theme.wifi_great)
        end
      else
        W.net.icon:set_image(theme.wifi_off)
      end
    end
  end
}
