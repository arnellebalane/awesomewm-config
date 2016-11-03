local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local modkey = "Mod4"

local shutdownicon = wibox.widget.imagebox()
shutdownicon:set_image(beautiful.shutdown_icon)

local shutdowntimer = timer({ timeout = 1 })
shutdowntimer:connect_signal("timeout", function()
    shutdowntimer:stop()
    awful.util.spawn_with_shell("sudo shutdown -P now")
end)

shutdownicon:buttons(awful.util.table.join(
    awful.button({ modkey }, 1, function()
        naughty.notify({
            text = "Shutting down...",
            position = "bottom_right",
            fg = "#ffffff",
            bg = "#009688",
            screen = mouse.screen
        })
        shutdowntimer:start()
    end)
))

return shutdownicon
