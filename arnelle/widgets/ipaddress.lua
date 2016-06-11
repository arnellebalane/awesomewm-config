local wibox = require("wibox")
local beautiful = require("beautiful")

local fd = io.popen("ifconfig")
local output = fd:read("*all")
fd:close()

local ip = string.match(output, "addr:(%d+%.%d+%.%d+%.%d+)")

local ipwidget = wibox.widget.textbox()
ipwidget:set_markup("<span fgcolor='" .. beautiful.ipaddress_color .. "'>" .. ip .. "</span>")



local ipicon = wibox.widget.imagebox()
ipicon:set_image(beautiful.ipaddress_icon)
local marginedipicon = wibox.layout.margin(ipicon, 0, 5, 4, 4)

local iplayout = wibox.layout.fixed.horizontal()
iplayout:add(marginedipicon)
iplayout:add(ipwidget)

return iplayout
