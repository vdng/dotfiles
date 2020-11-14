-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Xresources
local xresources = require("beautiful.xresources")
local dpi   = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local power_arrow = function (cr, width, height)
  gears.shape.powerline(cr, width, height, dpi(10))
end

function _M.get()
  local taglist = {}
  -- Create a wibox for each screen and add it
  taglist.buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
       client.focus:toggle_tag(t)
      end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )

  taglist.style = { 
      spacing = dpi(-11),
      shape = power_arrow 
  }

  taglist.layout = {
    spacing = dpi(10),
    spacing_widget = {
        color  = colorscheme['foreground'],
        shape  = power_arrow,
        widget = wibox.widget.separator,
    },
    layout  = wibox.layout.fixed.horizontal
  }

  taglist.widget_template = {
    {
      {
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      left  = dpi(18),
      right = dpi(18),
      widget = wibox.container.margin
    },
    id     = 'background_role',
    widget = wibox.container.background,
    create_callback = function (self, t, index, objects)
      self:connect_signal('mouse::enter', function()
        if self.bg ~= theme.cursorColor then
          self.backup     = self.bg
          self.has_backup = true
        end
        self.bg = theme.cursorColor
      end)
      self:connect_signal('mouse::leave', function()
        if self.has_backup then self.bg = self.backup end
      end)
    end
  }

  return taglist
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
