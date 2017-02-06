local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

-- TODO: make this relative to the awesomewm install directory
local command = "/home/arnelle/.config/awesome/arnelle/scripts/spotify"

local songwidget = wibox.widget.textbox()
local songwidgettimer = timer({ timer = 1 })
function displaysong()
    local fd = io.popen(command)
    local output = fd:read("*all")
    fd:close()

    songwidget:set_markup("<span fgcolor='" .. beautiful.song_color .. "'>" .. output .. "</span>")
end

displaysong()
songwidgettimer:connect_signal("timeout", displaysong)
songwidgettimer:start()



local songicon = wibox.widget.imagebox()
songicon:set_image(beautiful.song_icon)
local marginedsongicon = wibox.layout.margin(songicon, 0, 5, 5, 5)

local songlayout = wibox.layout.fixed.horizontal()
songlayout:add(marginedsongicon)
songlayout:add(songwidget)

songlayout:connect_signal("button::press", function()
    awful.client.run_or_raise("spotify", function(c)
        return awful.rules.match(c, { class = "Spotify" })
    end)
end)

return songlayout
