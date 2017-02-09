local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local config    = require("components/config")


local icon    = wibox.widget.imagebox(beautiful.icons.volume, false)
local textbox = wibox.widget.textbox("<span fgcolor='" .. beautiful.colors.white .. "'>0%</span>")
local layout  = wibox.widget({
    layout = wibox.layout.align.horizontal,
    icon,
    textbox,
})
local margin  = wibox.container.margin(layout, 6, 16, 0, 0)

local background_shape = function(cr, w, h) gears.shape.powerline(cr, w, h, -11) end
local background       = wibox.container.background(margin, beautiful.colors.dark_magenta, background_shape)
local widget           = wibox.container.margin(background, 0, -11, 0, 0)


function display_volume()
    local fd     = io.popen("amixer -D pulse sget Master")
    local output = fd:read("*all")
    fd:close()

    local volume = string.match(output, "%[(%d+)%%%]")
    local status = string.match(output, "%[(%a+)%]")

    if status == "on" then
        textbox:set_markup("<span fgcolor='" .. beautiful.colors.white .. "'>" .. volume .. "%</span>")
    else
        textbox:set_markup("<span fgcolor='" .. beautiful.colors.white .. "'>MUTE</span>")
    end


    return true
end

function mute()         awful.util.spawn("amixer -D pulse sset Master 1+ toggle") end
function raise_volume() awful.util.spawn("amixer set Master 2+")                  end
function lower_volume() awful.util.spawn("amixer set Master 2-")                  end


display_volume()
gears.timer.start_new(0.2, display_volume)


widget:buttons(awful.util.table.join(
    awful.button({ config.modkey }, 3, mute),
    awful.button({ config.modkey }, 4, raise_volume),
    awful.button({ config.modkey }, 5, lower_volume)))


widget.globalkeys = awful.util.table.join(
    awful.key({ }, "XF86AudioRaiseVolume", raise_volume),
    awful.key({ }, "XF86AudioLowerVolume", lower_volume),
    awful.key({ }, "XF86AudioMute",        mute))

return widget
