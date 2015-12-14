local wibox = require("wibox")

local volumewidget = wibox.widget.textbox()
local volumewidgettimer = timer({ timeout = 0.2 })
volumewidgettimer:connect_signal("timeout", function()
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)
    status = string.match(status, "%[(o[^%]])%]")

    if string.find(status, "on", 1, true) then
        volume = volume .. "% |"
    else
        volume = volume .. "M |"
    end
    volumewidget:set_text(volume)
end)
volumewidgettimer:start()

return volumewidget
