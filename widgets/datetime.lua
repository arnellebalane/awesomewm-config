local wibox            = require("wibox")
local gears            = require("gears")
local beautiful        = require("beautiful")


local format           = "%a %b %d, %I:%M:%S %p"
local timeout          = 1
local textclock        = wibox.widget.textclock(format, timeout)

local icon             = wibox.widget.imagebox(beautiful.widgets.datetime.icon, false)
local layout           = wibox.widget({
    layout = wibox.layout.align.horizontal,
    icon,
    textclock
})
local margin           = wibox.container.margin(layout, 6, 16, 0, 0)

local background_shape = function(cr, w, h) gears.shape.powerline(cr, w, h, -11) end
local background       = wibox.container.background(margin, beautiful.widgets.datetime.color, background_shape)
local widget           = wibox.container.margin(background, 0, -11, 0, 0)

return widget
