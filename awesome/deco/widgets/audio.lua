local awful       = require("awful")
local lain        = require("lain")
local markup      = lain.util.markup
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()
local math        = require("math")
local wibox       = require("wibox")

W.lain_volume = lain.widget.pulse()

W.volume = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  {
    {
      id = 'icon',
      image = theme.volume_off,
      widget = wibox.widget.imagebox
    },
    id = 'icon_margins',
    widget = wibox.container.margin,
    left = dpi(8),
    right = dpi(8)
  },
  {
    {
      id = 'text',
      widget = wibox.widget.textbox
    },
    id = 'text_margins',
    widget = wibox.container.margin,
    left = dpi(0),
    right = dpi(0)
  }
}

W.lain_volume = lain.widget.pulse ({
  settings = function()
    if volume_now.muted == "no" then
      if volume_now.right == volume_now.left then
        vlevel = volume_now.left
      else
        vlevel = volume_now.left .. " | " .. volume_now.right
      end
      local max_vlevel = math.max(tonumber(volume_now.left), tonumber(volume_now.right))
      W.volume.text_margins.text.markup = markup.fontfg(theme.font, theme.topright_widgets_fg, vlevel)
      W.volume.icon_margins.right = dpi(6)
      W.volume.text_margins.right = dpi(8)
      if max_vlevel <= 20 then
        W.volume.icon_margins.icon:set_image(theme.volume_low)
        return
      elseif max_vlevel <= 50 then
        W.volume.icon_margins.icon:set_image(theme.volume_mid)
        return
      else
        W.volume.icon_margins.icon:set_image(theme.volume_high)
        return
      end
    else
      W.volume.icon_margins.icon:set_image(theme.volume_off)
      W.volume.text_margins.text.markup = ''
      W.volume.icon_margins.right = dpi(8)
      W.volume.text_margins.right = dpi(0)
      return
    end
  end
})

W.volume:buttons(awful.util.table.join(
  awful.button({}, 1, function() -- left click
    awful.spawn(RC.vars.terminal .. " -e pulsemixer")
    --awful.spawn("pavucontrol")
  end),
  awful.button({}, 2, function() -- middle click
    os.execute(string.format("pactl set-sink-volume %s 100%%", W.lain_volume.device))
    W.lain_volume.update()
  end),
  awful.button({}, 3, function() -- right click
    os.execute(string.format("pactl set-sink-mute %s toggle", W.lain_volume.device))
    W.lain_volume.update()
  end),
  awful.button({}, 4, function() -- scroll up
    os.execute(string.format("pactl set-sink-volume %s +2%%", W.lain_volume.device))
    W.lain_volume.update()
  end),
  awful.button({}, 5, function() -- scroll down
    os.execute(string.format("pactl set-sink-volume %s -2%%", W.lain_volume.device))
    W.lain_volume.update()
  end)
))
