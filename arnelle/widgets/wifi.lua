local wibox = require("wibox")
local awful = require("awful")

local wifiwidget = wibox.widget.textbox()
wifiwidget:set_text(" Wifi |")
local wifiwidgettimer = timer({ timeout = 2 })
wifiwidgettimer:connect_signal("timeout", function()
    local wifistrength = awful.util.pread("awk 'NR==3 {printf \"%.1f%%\",($3/70)*100}' /proc/net/wireless")
    if wifistrength == "" then
        wifiwidget:set_text("")
    else
        wifiwidget:set_text(" " .. wifistrength .. " |")
    end
end)
wifiwidgettimer:start()

return wifiwidget
