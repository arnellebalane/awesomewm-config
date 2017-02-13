-- Layouts Configuration

local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local config    = require("components/config")


local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
}


layouts.buttons = awful.util.table.join(
    awful.button({ }, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 5, function() awful.layout.inc(layouts, 1) end))


layouts.globalkeys = awful.util.table.join(
    awful.key({ config.modkey          }, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({ config.modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),
    awful.key({ config.modkey          }, "l",     function() awful.tag.incmwfact(0.05) end),
    awful.key({ config.modkey          }, "h",     function() awful.tag.incmwfact(-0.05) end))


layouts.widget = function(s)
    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(layouts.buttons)
    local background = wibox.container.background(layoutbox, beautiful.colors.dark_gray)
    return background
end


return layouts
