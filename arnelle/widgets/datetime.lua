local wibox = require("wibox")
local vicious = require("vicious")

local datetimewidget = wibox.widget.textbox()
vicious.register(datetimewidget, vicious.widgets.date, "%a %b %d, %r", 1)

return datetimewidget
