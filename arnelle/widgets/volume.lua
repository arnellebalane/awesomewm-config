local wibox = require("wibox")
local awful = require("awful")

local volumewidget = awful.widget.progressbar({ width = 30 })
volumewidget:set_border_color("#ffffff")
volumewidget:set_color("#ffffff")
volumewidget:set_background_color("#673ab7")
volumewidget:set_value(90 / 100)

local marginedvolumewidget = wibox.layout.margin(volumewidget, 0, 0, 6, 6)

local volumewidgettimer = timer({ timeout = 0.2 })
local displayvolume = function()
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = string.match(status, "%[(%d+)%%%]")
    status = string.match(status, "%[(%a+)%]")

    if status == "off" then
        volumewidget:set_border_color("#f44336")
        volumewidget:set_color("#f44336")
    else
        volumewidget:set_border_color("#ffffff")
        volumewidget:set_color("#ffffff")
    end

    volumewidget:set_value(volume / 100)
end

displayvolume()
volumewidgettimer:connect_signal("timeout", displayvolume)
volumewidgettimer:start()

return marginedvolumewidget
