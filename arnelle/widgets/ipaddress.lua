local wibox = require("wibox")

local fd = io.popen("ifconfig")
local output = fd:read("*all")
fd:close()

local ip = string.match(output, "addr:(%d+%.%d+%.%d+%.%d+)")

local ipwidget = wibox.widget.textbox()
ipwidget:set_text(ip)

return ipwidget
