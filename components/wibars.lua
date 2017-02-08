-- Widget Bars Configuration

local awful   = require("awful")
local wibox   = require("wibox")
local layouts = require("components/layouts")
local tags    = require("components/tags")


awful.screen.connect_for_each_screen(function(s)
    s.promptbox = awful.widget.prompt({ prompt = "run: " })

    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(layouts.buttons)

    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, tags.buttons)

    s.wibox = awful.wibar({ position = "bottom", screen = s })
    s.wibox:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.layoutbox,
            s.taglist,
            s.promptbox,
        },
    })
end)
