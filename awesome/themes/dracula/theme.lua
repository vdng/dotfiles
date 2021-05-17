--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears       = require("gears")
local lain        = require("lain")
local awful       = require("awful")
local wibox       = require("wibox")
local naughty     = require("naughty")
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi
local colorscheme = xresources.get_current_theme()

local palette         = {
  background          = '#282a36',
  foreground          = '#f8f8f2',
  backgroundattention = '#181920',
  border              = '#282a36',
  currentline         = '#44475a',
  selection           = '#44475a',
  foreground          = '#f8f8f2',
  foregroundalt       = '#e0e0e0',
  foregroundattention = '#ffffff',
  comment             = '#6272a4',
  cyan                = '#8be9fd',
  green               = '#50fa7b',
  orange              = '#ffb86c',
  pink                = '#ff79c6',
  purple              = '#bd93f9',
  red                 = '#ff5555',
  yellow              = '#f1fa8c'
}

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme     = {}
theme.dir       = os.getenv("HOME") .. "/.config/awesome/themes/dracula"
theme.lain_icons = "/usr/share/lua/5.3/lain/icons/layout/default/"
theme.wallpaper = theme.dir .. "/wall.png"
theme.font      = "Sauce Sans Pro 11"
theme.bg_focus  = palette['selection']
theme.fg_focus  = palette['foreground']
theme.bg_normal = palette['background']
theme.fg_normal = palette['foreground']
theme.bg_urgent = palette['red']
theme.fg_urgent = palette['background']

-- clients
theme.border_width  = dpi(1)
theme.border_focus  = palette['pink']
theme.border_normal = palette['comment']
theme.border_marked = palette['orange']
theme.useless_gap   = dpi(0)

-- tasklist
theme.tasklist_bg_focus        = palette['background']
theme.tasklist_fg_focus        = palette['pink']
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon    = true

-- titlebar
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

-- taglist
theme.taglist_bg_focus    = palette['pink']
theme.taglist_fg_focus    = palette['foreground']
theme.taglist_bg_occupied = palette['comment']
theme.taglist_fg_occupied = palette['foreground']
theme.taglist_bg_empty    = palette['background']
theme.taglist_fg_empty    = palette['foreground']
theme.taglist_bg_volatile = palette['foreground']
theme.taglist_fg_volatile = palette['background']
theme.taglist_bg_urgent   = palette['yellow']
theme.taglist_fg_urgent   = palette['background']

-- layout
theme.layout_tile        = theme.dir .. "/icons/tile.png"
theme.layout_tileleft    = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom  = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop     = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv       = theme.dir .. "/icons/fairv.png"
theme.layout_fairh       = theme.dir .. "/icons/fairh.png"
theme.layout_spiral      = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle     = theme.dir .. "/icons/dwindle.png"
theme.layout_max         = theme.dir .. "/icons/max.png"
theme.layout_fullscreen  = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier   = theme.dir .. "/icons/magnifier.png"
theme.layout_floating    = theme.dir .. "/icons/floating.png"
theme.layout_centerfair  = theme.dir .. "/icons/centerfair.png"
theme.layout_centerwork  = theme.dir .. "/icons/centerwork.png"
theme.layout_centerworkh = theme.dir .. "/icons/centerworkh.png"
theme.layout_termfair    = theme.dir .. "/icons/termfair.png"

-- widgets
theme.widget_ac            = theme.dir .. "/icons/ac.png"
theme.widget_battery       = theme.dir .. "/icons/battery.png"
theme.widget_battery_low   = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem           = theme.dir .. "/icons/mem.png"
theme.widget_cpu           = theme.dir .. "/icons/cpu.png"
theme.widget_temp          = theme.dir .. "/icons/temp.png"
theme.widget_net           = theme.dir .. "/icons/net.png"
theme.widget_hdd           = theme.dir .. "/icons/hdd.png"
theme.widget_music         = theme.dir .. "/icons/note.png"
theme.widget_music_on      = theme.dir .. "/icons/note_on.png"
theme.widget_vol           = theme.dir .. "/icons/vol.png"
theme.widget_vol_low       = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no        = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute      = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail          = theme.dir .. "/icons/mail.png"
theme.widget_mail_on       = theme.dir .. "/icons/mail_on.png"
theme.widget_brightness    = theme.dir .. "/icons/sun.png"

-- Notifications
theme.notification_icon_size = 48
theme.notification_max_width = 300
--theme.notification_max_height = 80
theme.notification_border_width = 1
theme.notification_border_color = palette["selection"]
theme.notification_shape = gears.shape.rounded_rect
theme.notification_bg = palette["background"]
theme.notification_fg = palette["purple"]

naughty.config.padding = 4
naughty.config.spacing = 4

naughty.config.defaults.screen = screen.primary
naughty.config.defaults.bg = palette["background"]

naughty.config.presets.critical.bg = palette["background"]
naughty.config.presets.critical.fg = palette["red"]
naughty.config.presets.low.bg = palette["background"]
naughty.config.presets.low.fg = palette["comment"]

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "Terminus 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

local brightnessicon = wibox.widget.imagebox(theme.widget_brightness)
local brightness, brightness_timer = awful.widget.watch(
    "xbacklight -get", 2,
    function(widget, stdout)
        local brightness_level = tonumber(string.format("%.0f", stdout))
        widget:set_markup(markup.font(theme.font, brightness_level .. "% "))
    end
)

-- MPRIS
local musicicon = wibox.widget.imagebox(theme.widget_music)
local mpris, mpris_timer = awful.widget.watch(
    "playerctl -f '{{status}};{{xesam:artist}};{{xesam:title}};{{mpris:artUrl}};{{xesam:album}};{{xesam:albumArtist}}' metadata", 2,
    function(widget, stdout)
        local escape_f  = require("awful.util").escape
        local mpris_now = {
            state        = "N/A",
            artist       = "N/A",
            title        = "N/A",
            art_url      = "N/A",
            album        = "N/A",
            album_artist = "N/A"
        }

        mpris_now.state = string.match(stdout, "Playing") or
                          string.match(stdout, "Paused")  or "N/A"

        local words = {}
        for w in stdout:gmatch("([^;]*)") do table.insert(words, w) end

        mpris_now.state = words[1]
        mpris_now.artist = words[2]
        mpris_now.title = words[3]
        mpris_now.art_url = words[4]
        mpris_now.album = words[5]
        mpris_now.album_artist = words[6]

        if mpris_now.state == "Playing" then
            musicicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#ff79c6", mpris_now.artist) .. " " .. mpris_now.title .. " "))
        elseif mpris_now.state == "Paused" then
            musicicon:set_image(theme.widget_music)
            widget:set_markup(markup.font(theme.font, markup("#6272a4", mpris_now.artist) .. " " .. mpris_now.title .. " "))
        else
            musicicon:set_image(theme.widget_music)
            widget:set_markup(markup.font(theme.font, ""))
        end
    end
)

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
    end
})
--]]

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
        bat_notification_charged_preset = {
            title = "Battery full",
            text = "You can unplug the cable",
            timeout = naughty.config.presets.low.timeout,
            fg = naughty.config.presets.low.fg,
            bg = naughty.config.presets.low.bg
        }
        bat_notification_low_preset = {
            title = "Battery low",
            text = "Plug the cable !",
            timeout = naughty.config.presets.critical.timeout,
            fg = naughty.config.presets.critical.fg,
            bg = naughty.config.presets.critical.bg
        }
        bat_notification_critical_preset = {
            title = "Battery exhausted",
            text = "Imminent shutdown",
            timeout = naughty.config.presets.critical.timeout,
            fg = naughty.config.presets.critical.fg,
            bg = naughty.config.presets.critical.bg
        }
    end
})

-- Pulse volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.pulse({
    settings = function()
        local max_vlevel = math.max(tonumber(volume_now.left), tonumber(volume_now.right))
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(max_vlevel) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(max_vlevel) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        if volume_now.right == volume_now.left then
            vlevel = " " .. volume_now.left .. "% "
        else
            vlevel = " " .. volume_now.left .. "% | " .. volume_now.right .. "% "
        end
        widget:set_markup(markup.font(theme.font, vlevel ))
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup("#50FA7B", " " .. string.format("%03.1f", net_now.received))
                          .. " " ..
                          markup("#8BE9FD", " " .. string.format("%03.1f", net_now.sent) .. " ")))
    end
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.util.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, awful.util.tasklist_buttons)

    -- Create the systray
    s.systray = wibox.widget.systray()
    s.systray.visible = true

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            spr,
            arrl_ld,
            wibox.container.background(musicicon, theme.bg_focus),
            wibox.container.background(mpris, theme.bg_focus),
            arrl_dl,
            volicon,
            theme.volume.widget,
            arrl_ld,
            wibox.container.background(mailicon, theme.bg_focus),
            --wibox.container.background(theme.mail.widget, theme.bg_focus),
            arrl_dl,
            memicon,
            mem.widget,
            arrl_ld,
            wibox.container.background(cpuicon, theme.bg_focus),
            wibox.container.background(cpu.widget, theme.bg_focus),
            arrl_dl,
            tempicon,
            temp.widget,
            arrl_ld,
            wibox.container.background(brightnessicon, theme.bg_focus),
            wibox.container.background(brightness, theme.bg_focus),
            --wibox.container.background(theme.fs.widget, theme.bg_focus),
            arrl_dl,
            baticon,
            bat.widget,
            arrl_ld,
            wibox.container.background(neticon, theme.bg_focus),
            wibox.container.background(net.widget, theme.bg_focus),
            arrl_dl,
            clock,
            spr,
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_focus),
        },
    }
end

return theme
