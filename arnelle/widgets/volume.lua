local wibox = require("wibox")

local volumewidget = wibox.widget.textbox()
local volumewidgettimer = timer({ timeout = 0.2 })
local displayvolume = function()
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = string.match(status, "%[(%d+%%)%]")
    status = string.match(status, "%[(%a+)%]")

    if status == "off" then
        volume = volume .. " (mute)"
    end

    volumewidget:set_text(volume)
end

displayvolume()
volumewidgettimer:connect_signal("timeout", displayvolume)
volumewidgettimer:start()

return volumewidget
