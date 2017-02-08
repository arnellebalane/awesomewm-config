-- Rules Configuration

local awful     = require("awful")
local beautiful = require("beautiful")
local clients   = require("components/clients")


awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width         = beautiful.border_width,
            border_color         = beautiful.border_color,
            focus                = awful.client.focus.filter,
            raise                = true,
            keys                 = clients.keys,
            buttons              = clients.buttons,
            maximized_horizontal = false,
            maximized_vertical   = false
        }
    }
}
