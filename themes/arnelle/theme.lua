local theme_path = "/home/arnelle/.config/awesome/themes/arnelle/"

local theme      = {}
theme.theme_path = theme_path

theme.colors = {
    black         = "#1D1F21",
    white         = "#FFFFFF",
    dark_gray     = "#282A2E",
    dark_red      = "#A54242",
    dark_green    = "#8C9440",
    dark_yellow   = "#DE935F",
    dark_cyan     = "#5F819D",
    dark_magenta  = "#85678F",
    dark_teal     = "#5E8D87",
    light_gray    = "#373B41",
    light_red     = "#CC6666",
    light_green   = "#B5BD68",
    light_yellow  = "#F0C674",
    light_cyan    = "#81A2BE",
    light_magenta = "#B294BB",
    light_teal    = "#8ABEB7",
}

theme.icons = {
    number_1 = theme_path .. "icons/number-1.png",
    number_2 = theme_path .. "icons/number-2.png",
    number_3 = theme_path .. "icons/number-3.png",
}

theme.widgets = {
    poweroff  = {
        icon  = theme_path .. "icons/awesome.png",
        color = theme.colors.dark_red,
    },
    datetime  = {
        icon  = theme_path .. "icons/clock.png",
        color = theme.colors.dark_teal,
    },
    ipaddress = {
        icon  = theme_path .. "icons/ipaddress.png",
        color = theme.colors.dark_magenta,
    },
    volume    = {
        icon  = theme_path .. "icons/volume.png",
        color = theme.colors.dark_cyan,
    },
    spotify   = {
        icon  = theme_path .. "icons/note.png",
        color = theme.colors.dark_green,
    },
}

theme.font          = "terminus 8"

theme.bg_normal     = "transparent"
theme.bg_focus      = theme.colors.dark_red
theme.bg_urgent     = theme.colors.dark_yellow

theme.fg_normal     = theme.colors.white
theme.fg_focus      = theme.colors.white
theme.fg_urgent     = theme.colors.black
theme.fg_minimize   = theme.colors.white

theme.wallpaper     = theme_path .. "wallpaper.png"
theme.useless_gap   = 0

-- layout icons
theme.layout_tile       = theme_path .. "icons/layouts/tile-right.png"
theme.layout_tileleft   = theme_path .. "icons/layouts/tile-left.png"
theme.layout_tiletop    = theme_path .. "icons/layouts/tile-top.png"
theme.layout_tilebottom = theme_path .. "icons/layouts/tile-bottom.png"
theme.layout_floating   = theme_path .. "icons/layouts/floating.png"


return theme
