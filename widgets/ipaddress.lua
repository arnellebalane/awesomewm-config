local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")


local interfaces = { "eth0", "wlan0", "eno1", "lo" }
local ip

for i = 1, table.getn(interfaces) do
    local fd     = io.popen("ifconfig " .. interfaces[i])
    local output = fd:read("*all")
    fd:close()

    ip = string.match(output, "addr:(%d+%.%d+%.%d+%.%d+)")
    if ip then break end
end

if not ip then
    ip = "offline"
end


local markup  = "<span fgcolor='" .. beautiful.colors.white .. "'>" .. ip .. "</span>"
local textbox = wibox.widget.textbox(markup)
local icon    = wibox.widget.imagebox(beautiful.icons.ipaddress, false)
local layout  = wibox.widget({
    layout = wibox.layout.align.horizontal,
    icon,
    textbox,
})
local margin  = wibox.container.margin(layout, 6, 16, 0, 0)

local background_shape = function(cr, w, h) gears.shape.powerline(cr, w, h, -11) end
local background       = wibox.container.background(margin, beautiful.colors.dark_cyan, background_shape)
local widget           = wibox.container.margin(background, 0, -11, 0, 0)

return widget
