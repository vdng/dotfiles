-- Standard Awesome libraries
local gears = require("gears")
local awful = require("awful")

-- Cyclefocus widget
local cyclefocus = require("cyclefocus")

local modkey = RC.vars.modkey

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local clientkeys = gears.table.join(

    awful.key({ modkey, }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),

    -- Alt-Tab: cycle through clients on the same screen.
    cyclefocus.key({ "Mod1", }, "Tab", {
        cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
        keys = {'Tab', 'ISO_Left_Tab'}  -- default, could be left out
    }),

    -- Alt-$: cycle through clients with the same class name.
    cyclefocus.key({ "Mod1",          }, "$", 1, {
            cycle_filter = function (c, source_c) return c.class == source_c.class end,
    }),
    cyclefocus.key({ "Mod1", "Shift", }, "$", -1, {
            cycle_filter = function (c, source_c) return c.class == source_c.class end,
    }),

    awful.key({ modkey, "Shift"   }, "y",
              function (c) awful.client.focus.byidx(1) c:kill() end,
              {description = "close", group = "client"}),

    awful.key({ modkey, "Control" }, "space",
              awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Control" }, "Return",
              function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master" , group = "client"}),

    awful.key({ modkey,           }, "o",
              function (c) c:move_to_screen() end,
              {description = "move to screen" , group = "client"}),

    awful.key({ modkey,           }, "m",
              function (c) c.maximized = not c.maximized c:raise() end ,
              {description = "(un)maximize", group = "client"}),

    awful.key({ modkey, "Control" }, "m",
              function (c) c.maximized_vertical = not c.maximized_vertical c:raise() end ,
              {description = "(un)maximize vertically", group = "client"}),

    awful.key({ modkey, "Shift"   }, "m",
              function (c) c.maximized_horizontal = not c.maximized_horizontal c:raise() end ,
              {description = "(un)maximize horizontally", group = "client"})
  )

  return clientkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
