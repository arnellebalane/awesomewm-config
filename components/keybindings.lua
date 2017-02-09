-- Global Keybindings

local awful = require("awful")
local config = require("components/config")


return awful.util.table.join(
    -- screens
    awful.key({ config.modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    awful.key({ config.modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),

    -- prompts
    awful.key({ config.modkey            }, "r", function() awful.screen.focused().promptbox:run() end),

    -- standard program
    awful.key({ config.modkey, "Control" }, "r",      awesome.restart),
    awful.key({ config.modkey, "Control" }, "q",      awesome.quit),
    awful.key({ config.modkey            }, "u",      awful.client.urgent.jumpto),
    awful.key({ config.modkey            }, "Return", function() awful.spawn(config.terminal) end),

    -- media keys
    awful.key({ }, "XF86AudioPlay",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),
    awful.key({ }, "XF86AudioNext",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end),
    awful.key({ }, "XF86AudioPrev",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end)
)
