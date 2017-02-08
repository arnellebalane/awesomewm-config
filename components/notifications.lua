-- Notifications Configuration

local naughty   = require("naughty")
local beautiful = require("beautiful")


naughty.config.defaults.position     = "top_right"
naughty.config.defaults.margin       = 10
naughty.config.defaults.fg           = beautiful.naughty_fg or beautiful.fg_focus
naughty.config.defaults.bg           = beautiful.naughty_bg or beautiful.bg_focus
naughty.config.defaults.border_width = 0
naughty.config.defaults.timeout      = 5
naughty.config.defaults.icon_size    = 35
