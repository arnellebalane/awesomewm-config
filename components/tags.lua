-- Tags Component

local awful   = require("awful")
local config  = require("components/config")
local layouts = require("components/layouts")


local tags = {}
tags[1] = awful.tag({ "code", "terminal" }, 1, layouts[1])
tags[2] = awful.tag({ "www", "chat", "music", "files" }, 2, layouts[1])


tags.buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ config.modkey, "Shift" }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
            tag:view_only()
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewprev(tag.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(tag.screen) end))


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


return tags
