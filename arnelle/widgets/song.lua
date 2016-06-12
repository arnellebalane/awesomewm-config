local wibox = require("wibox")
local beautiful = require("beautiful")

local SP_DEST = "org.mpris.MediaPlayer2.spotify"
local SP_PATH = "/org/mpris/MediaPlayer2"
local SP_MEMB = "org.mpris.MediaPlayer2.Player"
local command = "dbus-send --print-reply --dest=" .. SP_DEST .. " " .. SP_PATH .. " org.freedesktop.DBus.Properties.Get string:'" .. SP_MEMB .. "' string:'Metadata'"
    .. " | grep -Ev '^method'"
    .. " | grep -Eo '(\"(.*)\")|(\\b[0-9][a-zA-Z0-9.]*\\b)'"
    .. " | sed -E '2~2 a|'"
    .. " | tr -d '\\n'"
    .. " | sed -E 's/\\|/\\n/g'"
    .. " | sed -E 's/(xesam:)|(mpris:)//'"
    .. " | sed -E 's/^\"|\"$//g'"
    .. " | sed -E 's/\"+/:/g'"
    .. " | sed -E 's/ +/ /g'"

local songwidget = wibox.widget.textbox()

local songwidgettimer = timer({ timer = 1 })
songwidgettimer:connect_signal("timeout", function()
    local fd = io.popen(command)
    local output = fd:read("*all")
    fd:close()

    local title = string.match(output, "title:(.*)%strackNumber")
    if not title then
        title = "Open Spotify"
    end
    songwidget:set_markup("<span fgcolor='" .. beautiful.song_color .. "'>" .. title .. "</span>")
end)
songwidgettimer:start()



local songicon = wibox.widget.imagebox()
songicon:set_image(beautiful.song_icon)
local marginedsongicon = wibox.layout.margin(songicon, 0, 5, 5, 5)

local songlayout = wibox.layout.fixed.horizontal()
songlayout:add(marginedsongicon)
songlayout:add(songwidget)

return songlayout