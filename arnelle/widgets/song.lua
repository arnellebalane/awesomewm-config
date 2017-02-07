local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local command = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'"
    .. "| grep -Ev '^method'"
    .. "| grep -Eo '(\"(.*)\")|(\\b[0-9][a-zA-Z0-9.]*\\b)'"
    .. "| sed -E '2~2 a|'"
    .. "| tr -d '\\n'"
    .. "| sed -E 's/\\|/\\n/g'"
    .. "| sed -E 's/(xesam:)|(mpris:)//'"
    .. "| sed -E 's/^\"|\"$//g'"
    .. "| sed -E 's/\"+/:/g'"
    .. "| sed -E 's/ +/ /g'"
    .. "| grep 'title'"
    .. "| sed -E 's/title://'"

local songwidget = wibox.widget.textbox()
function displaysong()
    local fd = assert(io.popen(command))
    local output = assert(fd:read("*all"))
    fd:close()

    songwidget:set_markup("<span fgcolor='" .. beautiful.song_color .. "'>" .. output .. "</span>")
    return true
end

displaysong()
gears.timer.start_new(1, displaysong)



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
