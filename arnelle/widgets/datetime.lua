local wibox = require("wibox")

local datetimewidget = wibox.widget.textbox()
local datetimewidgettimer = timer({ timeout = 1 })
local displaydatetime = function()
    local fd = io.popen("date +'%a %b %d, %r'")
    local output = fd:read("*all")
    fd:close()

    datetimewidget:set_text(output)
end

displaydatetime()
datetimewidgettimer:connect_signal("timeout", displaydatetime)
datetimewidgettimer:start()

return datetimewidget
