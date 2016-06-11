local wibox = require("wibox")
local beautiful = require("beautiful")

local datewidget = wibox.widget.textbox()
local timewidget = wibox.widget.textbox()

local datetimewidgettimer = timer({ timeout = 1 })
local displaydatetime = function()
    local fd = io.popen("date +'%a %b %d, %r'")
    local output = fd:read("*all")
    fd:close()

    local date = string.match(output, "(.+),")
    local time = string.match(output, ", (.+ .+) ")

    datewidget:set_markup("<span fgcolor='" .. beautiful.date_color .. "'>" .. date .. "</span>")
    timewidget:set_markup("<span fgcolor='" .. beautiful.time_color .. "'>" .. time .. "</span>")
end

displaydatetime()
datetimewidgettimer:connect_signal("timeout", displaydatetime)
datetimewidgettimer:start()



local datetimeicon = wibox.widget.imagebox()
datetimeicon:set_image(beautiful.datetime_icon)
local margineddatetimeicon = wibox.layout.margin(datetimeicon, 0, 5, 4, 5)

local widgetspacer = wibox.widget.textbox()
widgetspacer:set_text(" ")

local datetimelayout = wibox.layout.fixed.horizontal()
datetimelayout:add(margineddatetimeicon)
datetimelayout:add(datewidget)
datetimelayout:add(widgetspacer)
datetimelayout:add(timewidget)

return datetimelayout
