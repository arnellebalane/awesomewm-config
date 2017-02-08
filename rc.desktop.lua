local gears     = require("gears")
local awful     = require("awful")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local menubar   = require("menubar")



-- # error handling
-- check if awesome encountered an error during startup and fell back to
-- another config (this code will only execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title  = "Oops, there were errors during startup!",
        text   = awesome.startup_errors
    })
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title  = "Oops, an error happened!",
            text   = tostring(err)
        })
        in_error = false
    end)
end



-- # variable declarations
local terminal = "terminator"
local modkey = "Mod4"
local altkey = "Mod1"



-- # theme
beautiful.init("/home/arnelle/.config/awesome/arnelle/theme/theme.lua")

-- let gears module handle displaying the wallpaper
function reset_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper;
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    else
        gears.wallpaper.set("#263238")
    end
end

screen.connect_signal("property::geometry", reset_wallpaper)



-- # menubar
menubar.utils.terminal = terminal



-- # notifications
naughty.config.defaults.position     = "top_right"
naughty.config.defaults.margin       = 10
naughty.config.defaults.fg           = beautiful.naughty_fg or beautiful.fg_focus
naughty.config.defaults.bg           = beautiful.naughty_bg or beautiful.bg_focus
naughty.config.defaults.border_width = 0
naughty.config.defaults.timeout      = 5
naughty.config.defaults.icon_size    = 35



-- # layouts
local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
}

local layoutbuttons = awful.util.table.join(
    awful.button({ }, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 5, function() awful.layout.inc(layouts, 1) end))



-- # tags
awful.tag({ "code", "terminal" }, 1, layouts[1])
awful.tag({ "www", "chat", "music", "files" }, 2, layouts[1])

local tagbuttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey, "Shift" }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
            tag:view_only()
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewprev(tag.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(tag.screen) end))

local tagkeys = {}
for i = 1, 5 do
    tagkeys = awful.util.table.join(tagkeys,
        awful.key({ modkey            }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then tag:view_only() end
        end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end),
        awful.key({ modkey, "Shift"   }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end))
end



-- # wibars (previously wibox)
awful.screen.connect_for_each_screen(function(s)
    s.promptbox = awful.widget.prompt({ prompt = "run: " })

    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(layoutbuttons)

    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, tagbuttons)

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



-- # clients
local clientbuttons = awful.util.table.join(
    awful.button({ },        1, function(c)
        client.focus = c
        c:raise()
    end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

local clientkeys = awful.util.table.join(
    awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end),
    awful.key({ modkey }, "n", function(c) c.minimized = true end),
    awful.key({ modkey }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    end))



-- # keybindings
local globalkeys = awful.util.table.join(
    -- tags
    tagkeys,
    awful.key({ modkey            }, "Left",   awful.tag.viewprev),
    awful.key({ modkey, "Control" }, "h",      awful.tag.viewprev),
    awful.key({ modkey            }, "Right",  awful.tag.viewnext),
    awful.key({ modkey, "Control" }, "l",      awful.tag.viewnext),
    awful.key({ modkey            }, "Escape", awful.tag.history.restore),
    awful.key({ modkey            }, "=",      function() awful.tag.incnmaster(1) end),
    awful.key({ modkey            }, "-",      function() awful.tag.incnmaster(-1) end),

    -- screens
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),

    -- clients
    awful.key({ modkey }, "j", function()
        if client.focus then
            awful.client.focus.byidx(1)
            client.focus:raise()
        end
    end),
    awful.key({ modkey }, "k", function()
        if client.focus then
            awful.client.focus.byidx(-1)
            client.focus:raise()
        end
    end),
    awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- layouts
    awful.key({ modkey          }, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),
    awful.key({ modkey          }, "l",     function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey          }, "h",     function() awful.tag.incmwfact(-0.05) end),

    -- prompts
    awful.key({ modkey }, "r", function() awful.screen.focused().promptbox:run() end),

    -- menubar
    awful.key({ modkey }, "p", menubar.show),

    -- standard program
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Control" }, "q",      awesome.quit),
    awful.key({ modkey            }, "u",      awful.client.urgent.jumpto),
    awful.key({ modkey            }, "Return", function() awful.spawn(terminal) end),

    -- media keys
    awful.key({ }, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 2+") end),
    awful.key({ }, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 2-") end),
    awful.key({ }, "XF86AudioMute",        function() awful.util.spawn("amixer -D pulse sset Master 1+ toggle") end),
    awful.key({ }, "XF86AudioPlay",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),
    awful.key({ }, "XF86AudioNext",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end),
    awful.key({ }, "XF86AudioPrev",        function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end)
)

root.keys(globalkeys)



-- # rules
awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width         = beautiful.border_width,
            border_color         = beautiful.border_color,
            focus                = awful.client.focus.filter,
            raise                = true,
            keys                 = clientkeys,
            buttons              = clientbuttons,
            maximized_horizontal = false,
            maximized_vertical   = false
        }
    }
}



-- # signals
client.connect_signal("manage", function(c, startup)
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
            client.focus = c
            c:raise()
        end
    end)
end)
