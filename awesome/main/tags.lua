-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    local names   = {"", "", "龎", "", "", "", "", "ﱘ", ""}
    local l       = awful.layout.suit
    local layouts = { l.tile, l.tile_left, l.tile, l.tile, l.tile, l.tile, l.tile, l.tile, l.fair}
    tags[s]       = awful.tag(names, s, layouts)
  end)

  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
