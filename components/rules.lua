-- Rules Configuration

local awful     = require("awful")
local beautiful = require("beautiful")
local clients   = require("components/clients")
local tags      = require("components/tags")


awful.rules.rules = {
    {
        rule       = {},
        properties = {
            border_width         = beautiful.border_width,
            border_color         = beautiful.border_color,
            focus                = awful.client.focus.filter,
            raise                = true,
            keys                 = clients.keys,
            buttons              = clients.buttons,
            maximized            = false,
            size_hints_honor     = false,
        },
    },
    {
        rule       = { class = "Atom" },
        properties = {
            tag         = tags[1][1],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Sublime_text" },
        properties = {
            tag         = tags[1][1],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Terminator" },
        properties = {
            tag         = tags[1][2],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Hyper" },
        properties = {
            tag         = tags[1][2],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Rambox" },
        properties = {
            tag         = tags[1][4],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Google-chrome" },
        properties = {
            tag         = tags[1][3],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Nautilus" },
        properties = {
            tag         = tags[1][4],
            switchtotag = true,
        },
    },
    {
        rule       = { class = "Spotify" },
        properties = {
            tag         = tags[1][4],
            switchtotag = true,
        }
    },
}
