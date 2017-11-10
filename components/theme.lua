-- Theme Initialization

local awful     = require("awful")
local gears     = require("gears")
local beautiful = require("beautiful")
local config    = require("components/config")


local theme_path_template = "%s/.config/awesome/themes/%s/theme.lua"
local theme_path = string.format(theme_path_template, os.getenv("HOME"), config.theme)
beautiful.init(theme_path)


-- Display wallpaper on each screen
function display_wallpaper(s)
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

awful.screen.connect_for_each_screen(display_wallpaper)
screen.connect_signal("property::geometry", display_wallpaper)
