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
    awful.key({ config.modkey }, "m", function(c) c.maximized = not c.maximized end),
    awful.key({ config.modkey }, "s", function(c) c.sticky = not c.sticky end),
    awful.key({ config.modkey }, "d", function(c) c.floating = not c.floating end),
    awful.key({ config.modkey }, "t", function(c) c.ontop = not c.ontop end))


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
    awful.key({ config.modkey, "Control" }, "n", awful.client.restore),
    awful.key({ config.modkey, "Shift"   }, "l", function() awful.client.incwfact(0.1) end),
    awful.key({ config.modkey, "Shift"   }, "h", function() awful.client.incwfact(-0.1) end))


client.connect_signal("manage", function(c, startup)
    awful.client.setslave(c)

    c:connect_signal("mouse::enter", function(c)
        if awful.client.focus.filter(c) then
            client.focus = c
            c:raise()
        end
    end)
end)


return clients
