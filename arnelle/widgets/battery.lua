local wibox = require("wibox")

local batterywidget = wibox.widget.textbox()
batterywidget:set_text(" Battery")
local batterywidgettimer = timer({ timeout = 5 })
batterywidgettimer:connect_signal("timeout", function()
    fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))
    batterywidget:set_text(fh:read("*l"))
    fh:close()
end)
batterywidgettimer:start()

return batterywidget
