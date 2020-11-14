-------------------------------------------------
-- Spotify Widget for Awesome Window Manager
-- Shows currently playing song on Spotify for Linux client
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful   = require("awful")
local wibox   = require("wibox")
local watch   = require("awful.widget.watch")
local naughty = require("naughty")
local lain    = require("lain")
local markup  = lain.util.markup

-- Xresources
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()

local GET_SPOTIFY_STATUS_CMD = 'playerctl -p spotifyd status'
local GET_CURRENT_SONG_CMD   = 'playerctl -p spotifyd metadata'

local function ellipsize(text, length)
  return (text:len() > length and length > 0)
    and text:sub(0, length - 3) .. '...'
    or text
end

local args = args or {}

local play_icon    = args.play_icon or theme.play
local pause_icon   = args.pause_icon or theme.pause
local cast_icon    = args.cast_icon or theme.cast_audio
local artist_icon  = args.artist_icon or theme.artist
local track_icon   = args.track_icon or theme.music_note_eight
local album_icon   = args.album_icon or theme.album
local font         = args.font or theme.font
local fg           = args.fg or theme.bg_normal
local max_length   = args.max_length or 26
local show_tooltip = args.show_tooltip == nil and true or args.show_tooltip
local timeout      = args.timeout or 1

local cur_artist = ''
local cur_title  = ''
local cur_album  = ''

W.spt = wibox.widget {
  {
    {
      {
        id = 'artist_icon',
        image = artist_icon,
        widget = wibox.widget.imagebox
      },
      id = 'artist_icon_margins',
      widget = wibox.container.margin,
      left = dpi(8),
      right = dpi(8)
    },
    {
      {
        id = 'artist_text',
        font = font,
        widget = wibox.widget.textbox,
      },
      id = 'artist_text_margins',
      widget = wibox.container.margin,
      left = dpi(0),
      right = dpi(0)
    },
    layout = wibox.layout.fixed.horizontal,
    id     = 'artistw'
  },
  {
    id     = "icon",
    image  = theme.spotify,
    widget = wibox.widget.imagebox,
  },
  {
    {
      {
        id = 'title_icon',
        image = track_icon,
        widget = wibox.widget.imagebox
      },
      id = 'title_icon_margins',
      widget = wibox.container.margin,
      left = dpi(8),
      right = dpi(8)
    },
    {
      {
        id = 'title_text',
        font = font,
        widget = wibox.widget.textbox
      },
      id = 'title_text_margins',
      widget = wibox.container.margin,
      left = dpi(0),
      right = dpi(0)
    },
    id     = 'titlew',
    layout = wibox.layout.fixed.horizontal,
  },
  {
    {
      {
        id = 'album_icon',
        image = album_icon,
        widget = wibox.widget.imagebox
      },
      id = 'album_icon_margins',
      widget = wibox.container.margin,
      left = dpi(8),
      right = dpi(8)
    },
    {
      {
        id = 'album_text',
        font = font,
        widget = wibox.widget.textbox
      },
      id = 'album_text_margins',
      widget = wibox.container.margin,
      left = dpi(0),
      right = dpi(0)
    },
    id     = 'albumw',
    layout = wibox.layout.fixed.horizontal,
  },
  layout     = wibox.layout.fixed.horizontal,

  set_status = function(self, is_playing)
    if is_playing then
      self.icon.image = pause_icon
    elseif self.titlew.title_text_margins.title_text.text ~= '' then
      self.icon.image = cast_icon
    else
      self.icon.image = play_icon
    end
  end,

  set_text = function(self, artist, album, song)
    local artist_to_display = ellipsize(artist, max_length)
    if self.artistw.artist_text_margins.artist_text.text ~= artist_to_display then
      self.artistw.artist_text_margins.artist_text.markup = markup.fontfg(font, fg, artist_to_display)
      self.artistw.artist_icon_margins.right = dpi(6)
      self.artistw.artist_text_margins.right = dpi(8)
    end
    local title_to_display = ellipsize(song, max_length)
    if self.titlew.title_text_margins.title_text.text ~= title_to_display then
      self.titlew.title_text_margins.title_text.markup = markup.fontfg(font, fg, title_to_display)
      self.titlew.title_icon_margins.right = dpi(6)
      self.titlew.title_text_margins.right = dpi(8)
    end
    local album_to_display = ellipsize(album, max_length)
    if self.albumw.album_text_margins.album_text.text ~= album_to_display then
      self.albumw.album_text_margins.album_text.markup = markup.fontfg(font, fg, album_to_display)
      self.albumw.album_icon_margins.right = dpi(6)
      self.albumw.album_text_margins.right = dpi(8)
    end
  end
}

local concat_strings = function(it)
  local s = ''
  for v in it do
    s = s .. v .. '\n'
  end
  return string.sub(s, 1, -2)
end

local update_widget_icon = function(widget, stdout, _, _, _)
  stdout = string.gsub(stdout, "\n", "")
  widget:set_status(stdout == 'Playing' and true or false)
end

local update_widget_text = function(widget, stdout, _, _, _)
  if stdout == "No players found\n" then
    widget:set_text('','','')
    return
  end

  local escaped      = string.gsub(stdout, "&", '&amp;')
  local artists      = string.gmatch(escaped, 'artist%s+([%w%péèàâêöäüï ]*)')
  local albumArtists = string.gmatch(escaped, 'albumArtist%s+([%w%péèàâêöäüï ]*)')
  local album        = string.match(escaped, 'album%s+([%w%péèàâêöäüï ]*)')
  local title        = string.match(escaped, 'title%s+([%w%péèàâêöäüï ]*)')

  if title ~=nil then

    local artist      = concat_strings(artists)
    local albumArtist = concat_strings(albumArtists)

    cur_artist = artist
    cur_title  = title
    cur_album  = album

    widget:set_text(artist, album, title)
  end
end

watch(GET_SPOTIFY_STATUS_CMD, timeout, update_widget_icon, W.spt)
watch(GET_CURRENT_SONG_CMD, timeout, update_widget_text, W.spt)

--- Adds mouse controls to the widget:
--  - left click - play/pause
--  - scroll up - play next song
--  - scroll down - play previous song
W.spt:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then
        awful.spawn("sp play", false)      -- left click
    elseif (button == 4) then
        awful.spawn("sp next", false)  -- scroll up
    elseif (button == 5) then
        awful.spawn("sp prev", false)  -- scroll down
    end
    awful.spawn.easy_async(GET_SPOTIFY_STATUS_CMD, function(stdout, stderr, exitreason, exitcode)
        update_widget_icon(W.spt, stdout, stderr, exitreason, exitcode)
    end)
end)


if show_tooltip then
  local artist_tooltip = awful.tooltip {
    mode = 'outside',
  }
  artist_tooltip:add_to_object(W.spt.artistw)
  W.spt.artistw:connect_signal('mouse::enter', function()
    artist_tooltip.text = cur_artist
  end)

  local title_tooltip = awful.tooltip {
    mode = 'outside',
  }
  title_tooltip:add_to_object(W.spt.titlew)
  W.spt.titlew:connect_signal('mouse::enter', function()
    title_tooltip.text = cur_title
  end)

  local album_tooltip = awful.tooltip {
    mode = 'outside',
  }
  album_tooltip:add_to_object(W.spt.albumw)
  W.spt.albumw:connect_signal('mouse::enter', function()
    album_tooltip.text = cur_album
  end)
end

