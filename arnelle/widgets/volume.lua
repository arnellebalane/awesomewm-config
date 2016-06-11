local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local volumeicon = wibox.widget.imagebox()
volumeicon:set_image(beautiful.volume_on_icon)
local marginedvolumeicon = wibox.layout.margin(volumeicon, 0, 5, 5, 5)

local volumewidget = awful.widget.progressbar({ width = 30 })
volumewidget:set_border_color(beautiful.volume_on_color)
volumewidget:set_color(beautiful.volume_on_color)
volumewidget:set_background_color(beautiful.bg_normal)
local marginedvolumewidget = wibox.layout.margin(volumewidget, 0, 0, 6, 6)

local volumewidgettimer = timer({ timeout = 0.2 })
local displayvolume = function()
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = string.match(status, "%[(%d+)%%%]")
    status = string.match(status, "%[(%a+)%]")

    if status == "off" then
        volumewidget:set_border_color(beautiful.volume_off_color)
        volumewidget:set_color(beautiful.volume_off_color)
        volumeicon:set_image(beautiful.volume_off_icon)
    else
        volumewidget:set_border_color(beautiful.volume_on_color)
        volumewidget:set_color(beautiful.volume_on_color)
        volumeicon:set_image(beautiful.volume_on_icon)
    end

    volumewidget:set_value(volume / 100)
end

displayvolume()
volumewidgettimer:connect_signal("timeout", displayvolume)
volumewidgettimer:start()

local volumelayout = wibox.layout.fixed.horizontal()
volumelayout:add(marginedvolumeicon)
volumelayout:add(marginedvolumewidget)

return volumelayout
