-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Xresources
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()

-- Lain
local lain = require("lain")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist          = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local function wrap_widget(widget, background, margin_left, margin_right)
    return wibox.container.background(wibox.container.margin(widget, margin_left, margin_right), background)
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local markup     = lain.util.markup
local separators = lain.util.separators
local setar      = separators.arrow_left
local setal      = separators.arrow_right

-- Table for the lain widgets
W = {}

require("deco.widgets.audio")
require("deco.widgets.battery")
require("deco.widgets.brightness")
require("deco.widgets.net")
require("deco.widgets.spt")
require("deco.widgets.textclock")

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    style           = taglist.style,
    --layout        = taglist.layout,
    widget_template = taglist.widget_template,
    buttons         = taglist.buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.focused,
    buttons         = tasklist_buttons,
    widget_template = {
      setal("alpha", theme.tasklist_bg_focus),
      {
        {
          {
            {
              id     = 'text_role',
              widget = wibox.widget.textbox
            },
            layout          = wibox.layout.flex.horizontal,
            max_widget_size = dpi(800),
          },
          left   = dpi(35),
          right  = dpi(35),
          widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
      },
      setar(theme.tasklist_bg_focus, "alpha"),
      layout = wibox.layout.fixed.horizontal
    }
  }

  -- Top bar
  s.topbar = awful.wibar({ 
    position = "top",
    screen   = s ,
    height   = dpi(18)
  })

  s.topbar:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    s.mytaglist,
    s.mytasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      -- mykeyboardlayout,
      setar      ("alpha"                    , theme.topright_widgets_bg_1),
      wrap_widget(W.net                      , theme.topright_widgets_bg_1 , dpi(0), dpi(0)),

      setar      (theme.topright_widgets_bg_1, theme.topright_widgets_bg_2),
      wrap_widget(W.volume                   , theme.topright_widgets_bg_2 , dpi(0), dpi(0)),

      setar      (theme.topright_widgets_bg_2, theme.topright_widgets_bg_1),
      wrap_widget(W.brightness               , theme.topright_widgets_bg_1 , dpi(0), dpi(0)),

      setar      (theme.topright_widgets_bg_1, theme.topright_widgets_bg_2),
      wrap_widget(W.battery                  , theme.topright_widgets_bg_2 , dpi(0), dpi(0)),

      setar      (theme.topright_widgets_bg_2, theme.layout_widget_bg     ),
      wrap_widget(s.mylayoutbox              , theme.layout_widget_bg      , dpi(0), dpi(0)),
    },
  }

  -- Bottom bar
  s.bottombar = awful.wibar({
    position = "bottom",
    screen   = s,
    height   = dpi(18)
  })

  s.bottombar:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      s.mypromptbox,
    },
    {
      layout          = wibox.layout.fixed.horizontal,

      setal      ("alpha"           , theme.textclock_bg),
      wrap_widget(W.textclock       , theme.textclock_bg , dpi(0), dpi(0)),
      setar      (theme.textclock_bg, "alpha"           ),
    },
    {
      layout = wibox.layout.fixed.horizontal,

      setar      ("alpha"            , theme.spt_album_bg ),
      wrap_widget(W.spt.albumw       , theme.spt_album_bg  , dpi(0), dpi(0)),
      setar      (theme.spt_album_bg , theme.spt_track_bg ),
      wrap_widget(W.spt.titlew       , theme.spt_track_bg  , dpi(0), dpi(0)),
      setar      (theme.spt_track_bg , theme.spt_artist_bg),
      wrap_widget(W.spt.artistw      , theme.spt_artist_bg , dpi(0), dpi(0)),
      setar      (theme.spt_artist_bg, theme.spt_icon_bg  ),
      wrap_widget(W.spt.icon         , theme.spt_icon_bg   , dpi(0), dpi(0))
    }
  }

end)
