local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local config    = require("components/config")


local icon   = wibox.widget.imagebox(beautiful.widgets.poweroff.icon, false)
local margin = wibox.container.margin(icon, 6, 0, 0, 0)

local background_shape = function(cr, w, h) gears.shape.rectangular_tag(cr, w, h) end
local background       = wibox.container.background(margin, beautiful.widgets.poweroff.color, background_shape)


local counter = {
    beautiful.icons.number_3,
    beautiful.icons.number_2,
    beautiful.icons.number_1,
}
local index   = 1
local started = false


function poweroff_countdown()
    if index == 4 and started then
        started = false
        awful.spawn.with_shell("sudo shutdown -P now")
    end

    if started then
        icon.image = counter[index]
        index = index + 1
    else
        icon.image = beautiful.widgets.poweroff.icon
        index = 1
    end

    return started
end


local timer = nil

background:buttons(awful.util.table.join(
    awful.button({ config.modkey }, 1, function()
        if timer then
            timer:stop()
            timer = nil
        end

        started = not started
        poweroff_countdown()
        timer = gears.timer.start_new(1, poweroff_countdown)
    end)))


return background
