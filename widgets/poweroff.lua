local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")


local icon = wibox.widget.imagebox(beautiful.icons.awesome, false)
local margin = wibox.container.margin(icon, 6, 0, 0, 0)

local background_shape = function(cr, w, h) gears.shape.rectangular_tag(cr, w, h) end
local background = wibox.container.background(margin, beautiful.colors.dark_teal, background_shape)

return background
