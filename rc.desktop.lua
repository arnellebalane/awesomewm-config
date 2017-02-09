local gears     = require("gears")
local awful     = require("awful")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")

require("components/errors")
require("components/theme")
require("components/notifications")
require("components/rules")

local config      = require("components/config")
local menubar     = require("components/menubar")
local layouts     = require("components/layouts")
local tags        = require("components/tags")
local clients     = require("components/clients")
local keybindings = require("components/keybindings")
local wibars      = require("components/wibars")


root.keys(awful.util.table.join(
    menubar.globalkeys,
    layouts.globalkeys,
    tags.globalkeys,
    clients.globalkeys,
    wibars.globalkeys,
    keybindings
))
