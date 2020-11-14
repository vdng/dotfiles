local gears                    = require ("gears")
local xresources               = require("beautiful.xresources")
local dpi                      = xresources.apply_dpi
local colorscheme              = xresources.get_current_theme()
colorscheme.cursorColor        = "#FFFF00"

theme                          = {}

-- general
theme.conf_dir                 = os.getenv("HOME") .. "/.config/awesome/themes/vdng_lighthaus/"
theme.wallpaper                = theme.conf_dir .. "wallpaper.jpg"
theme.icons_dark_dir           = theme.conf_dir .. "icons_dark/"
theme.icons_light_dir          = theme.conf_dir .. "icons_light/"
theme.font                     = "Source Sans Pro 11"
theme.icon_font                = "Source Sans Pro 11"
theme.small_icon_font          = "Source Sans Pro 9"
theme.big_icon_font            = "Source Sans Pro 11"
theme.cursorColor              = colorscheme['cursorColor']

theme.bg_focus                 = colorscheme['background']
theme.fg_focus                 = colorscheme['foreground']

theme.bg_normal                = colorscheme['background']
theme.fg_normal                = colorscheme['foreground']

theme.bg_urgent                = colorscheme['color6']
theme.fg_urgent                = colorscheme['foreground']

theme.fg_minimized             = colorscheme['color7']

-- prompt
theme.prompt_bg_cursor         = colorscheme['cursorColor']
theme.prompt_fg_cursor         = colorscheme['background']
theme.prompt_bg                = colorscheme['background']
theme.prompt_fg                = colorscheme['foreground']

-- hotkeys
theme.hotkeys_bg               = colorscheme['background']
theme.hotkeys_fg               = colorscheme['foreground']

theme.hotkeys_label_bg         = colorscheme['color15']
theme.hotkeys_label_fg         = colorscheme['background']

-- taglist
theme.taglist_font             = "Source Sans Pro Mono 18"
theme.taglist_bg_focus         = colorscheme['cursorColor']
theme.taglist_fg_focus         = colorscheme['background']

theme.taglist_bg_occupied      = colorscheme['color14']
theme.taglist_fg_occupied      = colorscheme['background']

theme.taglist_bg_empty         = colorscheme['color8']
theme.taglist_fg_empty         = colorscheme['foreground']

theme.taglist_bg_volatile      = colorscheme['foreground']
theme.taglist_fg_volatile      = colorscheme['background']

theme.taglist_bg_urgent        = colorscheme['color3']
theme.taglist_fg_urgent        = colorscheme['foreground']

-- tasklist
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon    = true

theme.tasklist_bg_focus        = colorscheme['color8']
theme.tasklist_fg_focus        = colorscheme['cursorColor']

--theme.tasklist_align         = "center"

-- widgets
theme.topright_widgets_bg_1    = colorscheme['color8']
theme.topright_widgets_bg_2    = colorscheme['color0']
theme.topright_widgets_fg      = colorscheme['color15']
theme.textclock_bg             = colorscheme['foreground']
theme.layout_widget_bg         = colorscheme['color10']

-- media
theme.spotify                  = theme.icons_dark_dir .. "spotify.png"
theme.play                     = theme.icons_dark_dir .. "play.png"
theme.pause                    = theme.icons_dark_dir .. "pause.png"
theme.cast_audio               = theme.icons_dark_dir .. "cast-audio.png"
theme.artist                   = theme.icons_dark_dir .. "account-music.png"
theme.album                    = theme.icons_dark_dir .. "album.png"
theme.music_note_eight         = theme.icons_dark_dir .. "music-note-eighth.png"
theme.spt_artist_bg            = colorscheme['color4']
theme.spt_track_bg             = colorscheme['color12']
theme.spt_album_bg             = colorscheme['color4']
theme.spt_icon_bg              = colorscheme['color11']

-- textclock
theme.calendar_icon            = theme.icons_dark_dir .. "calendar-today.png"
theme.clock_icon               = theme.icons_dark_dir .. "clock.png"

-- network icons
theme.wifi_weak                = theme.icons_light_dir .. "wifi-strength-1.png"
theme.wifi_mid                 = theme.icons_light_dir .. "wifi-strength-2.png"
theme.wifi_good                = theme.icons_light_dir .. "wifi-strength-3.png"
theme.wifi_great               = theme.icons_light_dir .. "wifi-strength-4.png"
theme.wifi_off                 = theme.icons_light_dir .. "wifi-off.png"
theme.wifi_settings            = theme.icons_light_dir .. "wifi-settings.png"

-- brightness icons
theme.brightness_5             = theme.icons_light_dir .. "brightness-5.png"
theme.brightness_6             = theme.icons_light_dir .. "brightness-6.png"
theme.brightness_7             = theme.icons_light_dir .. "brightness-7.png"

-- volume icons
theme.volume_low               = theme.icons_light_dir .. "volume-low.png"
theme.volume_mid               = theme.icons_light_dir .. "volume-medium.png"
theme.volume_high              = theme.icons_light_dir .. "volume-high.png"
theme.volume_mute              = theme.icons_light_dir .. "volume-mute.png"
theme.volume_off               = theme.icons_light_dir .. "volume-off.png"

-- battery icons
theme.battery_10               = theme.icons_light_dir .. "battery-10.png"
theme.battery_20               = theme.icons_light_dir .. "battery-20.png"
theme.battery_30               = theme.icons_light_dir .. "battery-30.png"
theme.battery_40               = theme.icons_light_dir .. "battery-40.png"
theme.battery_50               = theme.icons_light_dir .. "battery-50.png"
theme.battery_60               = theme.icons_light_dir .. "battery-60.png"
theme.battery_70               = theme.icons_light_dir .. "battery-70.png"
theme.battery_80               = theme.icons_light_dir .. "battery-80.png"
theme.battery_90               = theme.icons_light_dir .. "battery-90.png"
theme.battery                  = theme.icons_light_dir .. "battery.png"

theme.power_plug               = theme.icons_light_dir .. "power-plug.png"
theme.battery_unknown          = theme.icons_light_dir .. "battery-unknown.png"

theme.battery_charging_10      = theme.icons_light_dir .. "battery-charging-10.png"
theme.battery_charging_20      = theme.icons_light_dir .. "battery-charging-20.png"
theme.battery_charging_30      = theme.icons_light_dir .. "battery-charging-30.png"
theme.battery_charging_40      = theme.icons_light_dir .. "battery-charging-40.png"
theme.battery_charging_50      = theme.icons_light_dir .. "battery-charging-50.png"
theme.battery_charging_60      = theme.icons_light_dir .. "battery-charging-60.png"
theme.battery_charging_70      = theme.icons_light_dir .. "battery-charging-70.png"
theme.battery_charging_80      = theme.icons_light_dir .. "battery-charging-80.png"
theme.battery_charging_90      = theme.icons_light_dir .. "battery-charging-90.png"
theme.battery_charging_100     = theme.icons_light_dir .. "battery-charging-100.png"

-- clients
theme.border_width             = dpi(3)

theme.border_focus             = colorscheme['cursorColor']
theme.border_normal            = colorscheme['color4']
theme.border_marked            = colorscheme['color6']

-- menu
theme.menu_border_width        = 1
theme.menu_height              = dpi(16)
theme.menu_width               = dpi(130)

theme.menu_bg_normal           = colorscheme['background']
theme.menu_fg_normal           = colorscheme['color7']

theme.menu_bg_focus            = colorscheme['cursorColor']
theme.menu_fg_focus            = colorscheme['background']

theme.menu_submenu_icon        = ""

-- wibar
theme.wibar_bg                 = colorscheme['background']

-- systemtray
theme.bg_systray               = colorscheme['color8']
theme.systray_icon_spacing     = dpi(15)

-- layouts
theme.useless_gap              = dpi(5)
theme.layouts_dir              = theme.conf_dir    .. "layouts/"
theme.layout_tile              = theme.layouts_dir .. "tile.png"
theme.layout_tilegaps          = theme.layouts_dir .. "tilegaps.png"
theme.layout_tileleft          = theme.layouts_dir .. "tileleft.png"
theme.layout_tilebottom        = theme.layouts_dir .. "tilebottom.png"
theme.layout_tiletop           = theme.layouts_dir .. "tiletop.png"
theme.layout_fairv             = theme.layouts_dir .. "fairv.png"
theme.layout_fairh             = theme.layouts_dir .. "fairh.png"
theme.layout_spiral            = theme.layouts_dir .. "spiral.png"
theme.layout_dwindle           = theme.layouts_dir .. "dwindle.png"
theme.layout_max               = theme.layouts_dir .. "max.png"
theme.layout_fullscreen        = theme.layouts_dir .. "fullscreen.png"
theme.layout_magnifier         = theme.layouts_dir .. "magnifier.png"
theme.layout_floating          = theme.layouts_dir .. "floating.png"
theme.layout_cornerse          = theme.layouts_dir .. "cornerse.png"
theme.layout_cornersw          = theme.layouts_dir .. "cornersw.png"
theme.layout_cornerne          = theme.layouts_dir .. "cornerne.png"
theme.layout_cornernw          = theme.layouts_dir .. "cornernw.png"

return theme
