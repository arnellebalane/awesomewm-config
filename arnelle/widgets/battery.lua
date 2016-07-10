local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local batterycolor_normal = "#ff5722"
local batterycolor_charging = "#00bcd4"

local batterywidget = awful.widget.progressbar({ width=30 })
batterywidget:set_border_color(batterycolor_normal)
batterywidget:set_color(batterycolor_normal)
batterywidget:set_background_color(beautiful.bg_normal)

local batterywidgettimer = timer({ timeout = 1 })
local displaybattery = function()
    local fd = io.popen("upower -i /org/freedesktop/UPower/devices/battery_BAT0")
    local output = fd:read("*all")
    fd:close()

    local batterylevel = string.match(output, "percentage: +(%d+)%%")
    local state = string.match(output, "state: +(%a+)")

    if state == "charging" then
        batterywidget:set_border_color(batterycolor_charging)
        batterywidget:set_color(batterycolor_charging)
    else
        batterywidget:set_border_color(batterycolor_normal)
        batterywidget:set_color(batterycolor_normal)
    end

    batterywidget:set_value(batterylevel / 100)
end

displaybattery()
batterywidgettimer:connect_signal("timeout", displaybattery)
batterywidgettimer:start()


local marginedbatterywidget = wibox.layout.margin(batterywidget, 0, 0, 6, 6)

return marginedbatterywidget
