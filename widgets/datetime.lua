local wibox            = require("wibox")
local gears            = require("gears")
local beautiful        = require("beautiful")


local format           = "%a %b %d, %I:%M:%S %p"
local timeout          = 1
local textclock        = wibox.widget.textclock(format, timeout)

local icon             = wibox.widget.imagebox(beautiful.icons.clock, false)
local layout           = wibox.widget({
    layout = wibox.layout.align.horizontal,
    icon,
    textclock
})
local margin           = wibox.container.margin(layout, 6, 16, 0, 0)

local background_shape = function(cr, w, h) gears.shape.powerline(cr, w, h, -11) end
local background       = wibox.container.background(margin, beautiful.colors.dark_red, background_shape)


return background
