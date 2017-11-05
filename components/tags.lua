-- Tags Component

local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local config    = require("components/config")
local layouts   = require("components/layouts")


local tags = {}
local screen_count = screen:count()

if screen_count == 1 then
    tags[1] = awful.tag({ "", "", "", "" }, 1, layouts[1])

    awful.tag.seticon(beautiful.theme_path .. "icons/code.png", tags[1][1])
    awful.tag.seticon(beautiful.theme_path .. "icons/terminal.png", tags[1][2])
    awful.tag.seticon(beautiful.theme_path .. "icons/www.png", tags[1][3])
    awful.tag.seticon(beautiful.theme_path .. "icons/chat.png", tags[1][4])
elseif screen_count == 2 then
    tags[1] = awful.tag({ "", "", "", "" }, 1, layouts[1])
    tags[2] = awful.tag({ "", "", "", "" }, 2, layouts[1])

    awful.tag.seticon(beautiful.theme_path .. "icons/code.png", tags[1][1])
    awful.tag.seticon(beautiful.theme_path .. "icons/terminal.png", tags[1][2])
    awful.tag.seticon(beautiful.theme_path .. "icons/code.png", tags[1][3])
    awful.tag.seticon(beautiful.theme_path .. "icons/code.png", tags[1][4])
    awful.tag.seticon(beautiful.theme_path .. "icons/www.png", tags[2][1])
    awful.tag.seticon(beautiful.theme_path .. "icons/chat.png", tags[2][2])
    awful.tag.seticon(beautiful.theme_path .. "icons/music.png", tags[2][3])
    awful.tag.seticon(beautiful.theme_path .. "icons/files.png", tags[2][4])
end


tags.buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ config.modkey, "Shift" }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
            t:view_only()
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end))


tags.globalkeys = awful.util.table.join(
    awful.key({ config.modkey            }, "Left",   awful.tag.viewprev),
    awful.key({ config.modkey, "Control" }, "h",      awful.tag.viewprev),
    awful.key({ config.modkey            }, "Right",  awful.tag.viewnext),
    awful.key({ config.modkey, "Control" }, "l",      awful.tag.viewnext),
    awful.key({ config.modkey            }, "Escape", awful.tag.history.restore),
    awful.key({ config.modkey            }, "=",      function() awful.tag.incnmaster(1) end),
    awful.key({ config.modkey            }, "-",      function() awful.tag.incnmaster(-1) end))

for i = 1, 5 do
    tags.globalkeys = awful.util.table.join(tags.globalkeys,
        awful.key({ config.modkey            }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then tag:view_only() end
        end),
        awful.key({ config.modkey, "Control" }, "#" .. i + 9, function()
            local tag = awful.screen.focused().tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end),
        awful.key({ config.modkey, "Shift"   }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end))
end


tags.widget = function(s)
    local taglist_filter = awful.widget.taglist.filter.all
    local taglist = awful.widget.taglist(s, taglist_filter, tags.buttons)
    local background = wibox.container.background(taglist, beautiful.colors.light_gray)
    return background
end


return tags
