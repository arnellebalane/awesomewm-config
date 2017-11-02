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

    -- screenshot (requires `scrot`)
    awful.key({                          }, "Print",  function()
        local output_path = "/home/arnelle/Pictures/screenshots/" .. os.date("%Y-%m-%d-%H%M%S" .. ".jpg")
        awful.spawn.with_shell("sleep 0.5 && scrot " .. output_path)
    end),
    awful.key({ "Shift"                  }, "Print",  function()
        local output_path = "/home/arnelle/Pictures/screenshots/" .. os.date("%Y-%m-%d-%H%M%S" .. ".jpg")
        awful.spawn.with_shell("sleep 0.5 && scrot -s " .. output_path)
    end),

    -- screen lock (requires `xtrlock`)
    awful.key({ config.modkey            }, "F12",    function() awful.spawn("xtrlock") end),

    -- spawn dev environment
    awful.key({ config.modkey, "Control" }, "d",      function()
        awful.spawn("subl")
        awful.spawn(config.terminal)
        awful.spawn("google-chrome")
        awful.spawn("rambox")
    end)
)
