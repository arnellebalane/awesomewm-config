-- Menubar Configuration

local awful   = require("awful")
local menubar = require("menubar")
local config  = require("components/config")


menubar.utils.terminal = config.terminal


menubar.globalkeys = awful.util.table.join(
    awful.key({ config.modkey }, "p", menubar.show))


return menubar
