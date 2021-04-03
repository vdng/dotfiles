# Lighthaus theme

black       = "#21252D"
grey        = "#8E8D8D"

red         = "#FC2929"
red2        = "#FF5050"

green       = "#44B273"
green2      = "#50C16E"

orange      = "#E25600"
orange2     = "#ED722E"

blue        = "#1D918B"
blue2       = "#47A8A1"

purple      = "#D16BB7"
purple2     = "#D68EB2"

cyan        = "#00BFA4"
cyan2       = "#5AD1AA"

white       = "#FFFADE"
white2      = "#CCCCCC"

bg          = "#18191E"
fg          = "#FFEE79"

hl_yellow   = "#FFFF00"
hl_orange   = "#FF4D00"
hl_bg       = "#090B26"

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = green

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = bg

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = green

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = black

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = bg

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = [fg, white, white2]

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = hl_yellow

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = hl_yellow

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = hl_yellow

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = bg

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = orange

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = hl_orange

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = black

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = hl_bg

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = hl_yellow

# Background color of disabled items in the context menu. If set to
# null, the Qt default is used.
# Type: QssColor
c.colors.contextmenu.disabled.bg = black

# Foreground color of disabled items in the context menu. If set to
# null, the Qt default is used.
# Type: QssColor
c.colors.contextmenu.disabled.fg = grey

# Background color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.bg = bg

# Foreground color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.fg =  fg

# Background color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.bg = hl_yellow

# Foreground color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.fg = bg

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = bg

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = red

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = white

# Color gradient start for download backgrounds.
# Type: QtColor
c.colors.downloads.start.bg = purple2

# Color gradient start for download text.
# Type: QtColor
c.colors.downloads.start.fg = bg

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = blue2

# Color gradient end for download text.
# Type: QtColor
c.colors.downloads.stop.fg = bg

# Color gradient interpolation system for download backgrounds.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
#c.colors.downloads.system.bg = 'rgb'

# Color gradient interpolation system for download text.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
#c.colors.downloads.system.fg = 'rgb'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = bg

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = fg

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = orange

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = bg

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = fg

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = purple

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = red2

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = red2

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = bg

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = blue2

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = blue2

# Foreground color of an info message.
# Type: QssColor
c.colors.messages.info.fg = bg

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = orange2

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = orange2

# Foreground color of a warning message.
# Type: QssColor
c.colors.messages.warning.fg = bg

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = bg

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = '1px solid ' + black

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = fg

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = black

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = blue

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = bg

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = orange2

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = bg

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = black

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = fg

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = hl_bg

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = white2

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = green2

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = bg

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = bg

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = orange2

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = purple2

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = bg

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = hl_bg

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = white2

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = fg

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = red

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = white

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = cyan2

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = white2

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = fg

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = cyan2

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = bg

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = bg

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = white2

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = red

# Color gradient start for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.start = purple2

# Color gradient end for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.stop = blue2

# Color gradient interpolation system for the tab indicator.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
#c.colors.tabs.indicator.system = 'rgb'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = black

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = white2

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = bg

# Foreground color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.fg = white2

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = black

# Foreground color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.fg = white2

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = cyan

# Foreground color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.fg = bg

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = cyan

# Foreground color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = bg

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = cyan

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = bg

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = cyan

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = bg

# Background color for webpages if unset (or empty to use the theme's
# color).
# Type: QtColor
c.colors.webpage.bg = ''

# CSS border value for hints.
# Type: String
c.hints.border = '1px solid ' + fg
