-- Clients Configuration

local awful  = require("awful")
local config = require("components/config")


local clients = {}


clients.buttons = awful.util.table.join(
    awful.button({ },        1, function(c)
        client.focus = c
        c:raise()
    end),
    awful.button({ config.modkey }, 1, awful.mouse.client.move),
    awful.button({ config.modkey }, 3, awful.mouse.client.resize))


clients.keys = awful.util.table.join(
    awful.key({ config.modkey }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ config.modkey }, "q", function(c) c:kill() end),
    awful.key({ config.modkey }, "o", function(c) c:move_to_screen() end),
    awful.key({ config.modkey }, "n", function(c) c.minimized = true end),
    awful.key({ config.modkey }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    end))


clients.globalkeys = awful.util.table.join(
    awful.key({ config.modkey }, "j", function()
        if client.focus then
            awful.client.focus.byidx(1)
            client.focus:raise()
        end
    end),
    awful.key({ config.modkey }, "k", function()
        if client.focus then
            awful.client.focus.byidx(-1)
            client.focus:raise()
        end
    end),
    awful.key({ config.modkey, "Shift"   }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ config.modkey, "Shift"   }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ config.modkey, "Control" }, "n", awful.client.restore))


client.connect_signal("manage", function(c, startup)
    c:connect_signal("mouse::enter", function(c)
        if awful.client.focus.filter(c) then
            client.focus = c
            c:raise()
        end
    end)
end)


return clients
