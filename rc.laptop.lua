local awful = require("awful")
awful.rules = require("awful.rules");
require("awful.autofocus")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")



-- # error handling
-- check if awesome encountered an error during startup and fell back to
-- another config (this code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(error)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = error
        })
        in_error = false
    end)
end



-- # theme
beautiful.init("/home/arnelle/.config/awesome/arnelle/theme/theme.lua")

-- let gears module handle displaying of the wallpapers
if beautiful.wallpaper then
    gears.wallpaper.maximized(beautiful.wallpaper, nil, true)
else
    gears.wallpaper.set("#263238")
end



-- # variables
local terminal = "/home/arnelle/bin/hyper"

-- usually, Mod4 is the key with a logo between Control and Alt.
local modkey = "Mod4"



-- # menubar
menubar.utils.terminal = terminal



-- # notifications
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 10
naughty.config.defaults.fg = beautiful.naughty_fg or beautiful.fg_focus
naughty.config.defaults.bg = beautiful.naughty_bg or beautiful.bg_focus
naughty.config.defaults.border_width = 0
naughty.config.defaults.timeout = 5



-- # layouts
local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    awful.layout.suit.max.fullscreen
}

local layoutbuttons = awful.util.table.join(
    awful.button({ }, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function() awful.layout.inc(layouts, -1) end),
    awful.button({ }, 5, function() awful.layout.inc(layouts, 1) end))



-- # tags
tags = {}
tags[1] = awful.tag({ "terminal", "code", "www", "music", "files" }, 1, layouts[1])
for s = 2, screen.count() do
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end

local tagbuttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey, "Shift" }, 1, function(t)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end))

local tagkeys = {}
for i = 1, 9 do
    tagkeys = awful.util.table.join(tagkeys,
        awful.key({ modkey }, "#" .. i + 9, function()
            local tag = awful.tag.gettags(mouse.screen)[i]
            if tag then awful.tag.viewonly(tag) end
        end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local tag = awful.tag.gettags(mouse.screen)[i]
            if tag then awful.tag.viewtoggle(tag) end
        end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = awful.tag.gettags(client.focus.screen)[i]
                if tag then
                    awful.client.movetotag(tag)
                    awful.tag.viewonly(tag)
                end
            end
        end),
        awful.key({ modkey, "Mod1" }, "#" .. i + 9, function()
            if client.focus then
                local c = client.focus
                awful.screen.focus_relative(1)
                local tag = awful.tag.gettags(mouse.screen)[i]
                if tag then
                    awful.client.movetotag(tag, c)
                    awful.tag.viewonly(tag)
                end
            end
        end))
end



-- # widgets
local datetimewidget = require("arnelle/widgets/datetime")
local volumewidget = require("arnelle/widgets/volume")
local ipaddresswidget = require("arnelle/widgets/ipaddress")
local songwidget = require("arnelle/widgets/song")
local batterywidget = require("arnelle/widgets/battery")

local widgetspacer = wibox.widget.textbox()
widgetspacer:set_text(" ")
local widgetspacerwide = wibox.widget.textbox()
widgetspacerwide:set_text("   ")



-- # wibox
local wiboxes = {}
local layoutboxes = {}
local taglists = {}
local promptboxes = {}

for s = 1, screen.count() do
    layoutboxes[s] = awful.widget.layoutbox(s)
    layoutboxes[s]:buttons(layoutbuttons)
    taglists[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, tagbuttons)
    promptboxes[s] = awful.widget.prompt({ prompt = "run: " })

    wiboxes[s] = awful.wibox({ position = "bottom", screen = s })

    local leftwidgets = wibox.layout.fixed.horizontal()
    leftwidgets:add(layoutboxes[s])
    leftwidgets:add(taglists[s])
    leftwidgets:add(widgetspacer)
    leftwidgets:add(promptboxes[s])

    local rightwidgets = wibox.layout.fixed.horizontal()
    rightwidgets:add(songwidget)
    rightwidgets:add(widgetspacerwide)
    rightwidgets:add(volumewidget)
    rightwidgets:add(widgetspacerwide)
    rightwidgets:add(batterywidget)
    rightwidgets:add(widgetspacerwide)
    rightwidgets:add(ipaddresswidget)
    rightwidgets:add(widgetspacerwide)
    rightwidgets:add(datetimewidget)
    rightwidgets:add(widgetspacer)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(leftwidgets)
    layout:set_right(rightwidgets)
    wiboxes[s]:set_widget(layout)
end



-- # clients
local clientkeys = awful.util.table.join(
    awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey }, "o", awful.client.movetoscreen),
    awful.key({ modkey }, "n", function(c) c.minimized = true end),
    awful.key({ modkey }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical = not c.maximized_vertical
    end))

local clientbuttons = awful.util.table.join(
    awful.button({ },        1, function(c)
        client.focus = c
        c:raise()
    end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

highlight_focus = false



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
    awful.key({ modkey }, "j",   function()
        if client.focus then
            awful.client.focus.byidx(1)
            client.focus:raise()
        end
    end),
    awful.key({ modkey }, "k",   function()
        if client.focus then
            awful.client.focus.byidx(-1)
            client.focus:raise()
        end
    end),
    awful.key({ modkey, "Shift" }, "j",   function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k",   function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey          }, "Tab", awful.client.focus.history.previous),

    -- layouts
    awful.key({ modkey            }, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(layouts, -1) end),
    awful.key({ modkey            }, "l",     function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey            }, "h",     function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Control" }, "n",     awful.client.restore),

    -- prompts
    awful.key({ modkey }, "r", function() promptboxes[mouse.screen]:run() end),

    -- menubar
    awful.key({ modkey }, "p", menubar.show),

    -- standard program
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Control" }, "q",      awesome.quit),
    awful.key({ modkey            }, "u",      awful.client.urgent.jumpto),
    awful.key({ modkey            }, "Return", function() awful.util.spawn(terminal) end),

    -- screenlock (requires xtrlock)
    awful.key({ modkey }, "F12", function() awful.util.spawn("xtrlock") end),

    -- screenshot (requires scrot)
    awful.key({ },         "Print", function()
        local outputpath = "/home/arnelle/Pictures/screenshots/" .. os.date("%Y-%m-%d-%H%M%S") .. ".jpg"
        awful.util.spawn_with_shell("sleep 0.5 && scrot " .. outputpath)
    end),
    awful.key({ "Shift" }, "Print", function()
        local outputpath = "/home/arnelle/Pictures/screenshots/" .. os.date("%Y-%m-%d-%H%M%S") .. ".jpg"
        awful.util.spawn_with_shell("sleep 0.5 && scrot -s " .. outputpath)
    end),

    -- media keys
    awful.key({ }, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer -D pulse set Master 5%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function() awful.util.spawn("amixer -D pulse set Master 5%-") end),
    awful.key({ }, "XF86AudioMute", function() awful.util.spawn("amixer -D pulse sset Master 1+ toggle") end),
    awful.key({ }, "XF86AudioPlay", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),
    awful.key({ }, "XF86AudioNext", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end),
    awful.key({ }, "XF86AudioPrev", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end),

    -- toggle highlighting current client
    awful.key({ modkey }, "F1", function()
        highlight_focus = not highlight_focus
        if client.focus then
            if highlight_focus then
                client.focus.border_color = beautiful.border_focus
            else
                client.focus.border_color = beautiful.border_normal
            end
        end
    end))

root.keys(globalkeys)



-- # rules
awful.rules.rules = {
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false,
            maximized_horizontal = false,
            maximized_vertical = false
        }
    },
    {
        rule = { class = "Atom" },
        properties = { tag = tags[1][2], switchtotag = true }
    },
    {
        rule = { class = "Terminator" },
        properties = { tag = tags[1][1], switchtotag = true }
    },
    {
        rule = { class = "URxvt" },
        properties = {
            tag = tags[1][1],
            switchtotag = true,
            border_width = 1,
            border_color = beautiful.border_normal
        }
    },
    {
        rule = { class = "Hyper" },
        properties = { tag = tags[1][1], switchtotag = true }
    },
    {
        rule = { class = "Google-chrome" },
        properties = { tag = tags[1][3], switchtotag = true }
    },
    {
        rule = { class = "Nautilus" },
        properties = { tag = tags[1][5], switchtotag = true }
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

client.connect_signal("focus", function(c)
    if highlight_focus then c.border_color = beautiful.border_focus end
end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
