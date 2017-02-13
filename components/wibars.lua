-- Widget Bars Configuration

local awful   = require("awful")
local wibox   = require("wibox")
local layouts = require("components/layouts")
local tags    = require("components/tags")

local spotify   = require("widgets/spotify")
local volume    = require("widgets/volume")
local ipaddress = require("widgets/ipaddress")
local datetime  = require("widgets/datetime")
local poweroff  = require("widgets/poweroff")


awful.screen.connect_for_each_screen(function(s)
    s.promptbox = awful.widget.prompt({ prompt = "run: " })

    s.wibox = awful.wibar({
        screen   = s,
        position = "bottom",
        height   = 22,
    })
    s.wibox:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            layouts.widget(s),
            tags.widget(s),
            s.promptbox,
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            spotify,
            volume,
            ipaddress,
            datetime,
            poweroff,
        }
    })
end)


local component      = {}
component.globalkeys = awful.util.table.join(
    spotify.globalkeys,
    volume.globalkeys)

return component
