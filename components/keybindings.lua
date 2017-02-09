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
    awful.key({ config.modkey            }, "Return", function() awful.spawn(config.terminal) end))
