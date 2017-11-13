local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local config    = require("components/config")
local naughty   = require("naughty")


local icon    = wibox.widget.imagebox(beautiful.widgets.spotify.icon, false)
local textbox = wibox.widget.textbox("<span fgcolor='" .. beautiful.colors.white .. "'>Open Spotify</span>")
local layout  = wibox.widget({
    layout = wibox.layout.align.horizontal,
    icon,
    textbox,
})
local margin  = wibox.container.margin(layout, 6, 16, 0, 0)

local background_shape = function(cr, w, h) gears.shape.powerline(cr, w, h, -11) end
local background       = wibox.container.background(margin, beautiful.widgets.spotify.color, background_shape)
local widget           = wibox.container.margin(background, 0, -11, 0, 0)


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


function display_song()
    local fd     = io.popen(command)
    local output = fd:read("*all")
    fd:close()

    if string.len(output) == 0 then
        output = "Open Spotify"
    end

    textbox:set_markup("<span fgcolor='" .. beautiful.colors.white .. "'>" .. output .. "</span>")
    return true
end

function toggle_song()   awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end
function next_song()     awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")      end
function previous_song() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")  end

function open_spotify()
    awful.client.run_or_raise("spotify", function(c)
        return awful.rules.match(c, { class = "Spotify" })
    end)
end


display_song()
gears.timer.start_new(0.5, display_song)


widget:buttons(awful.util.table.join(
    awful.button({ config.modkey }, 1, open_spotify),
    awful.button({ config.modkey }, 3, toggle_song),
    awful.button({ config.modkey }, 4, previous_song),
    awful.button({ config.modkey }, 5, next_song)))


widget.globalkeys = awful.util.table.join(
    awful.key({ }, "XF86AudioPlay", toggle_song),
    awful.key({ }, "XF86AudioNext", next_song),
    awful.key({ }, "XF86AudioPrev", previous_song),

    awful.key({ config.modkey, "Control" }, "space", toggle_song),
    awful.key({ config.modkey, "Control" }, "Right", next_song),
    awful.key({ config.modkey, "Control" }, "Left", previous_song))


return widget
