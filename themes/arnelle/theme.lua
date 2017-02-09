local theme  = {}
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
    awesome   = "/home/arnelle/.config/awesome/themes/arnelle/icons/awesome.png",
    clock     = "/home/arnelle/.config/awesome/themes/arnelle/icons/clock.png",
    ipaddress = "/home/arnelle/.config/awesome/themes/arnelle/icons/ipaddress.png",
}

theme.font          = "terminus 8"

theme.bg_normal     = theme.colors.dark_gray
theme.bg_focus      = theme.colors.dark_red
theme.bg_urgent     = theme.colors.dark_yellow

theme.fg_normal     = theme.colors.white
theme.fg_focus      = theme.colors.white
theme.fg_urgent     = theme.colors.black
theme.fg_minimize   = theme.colors.white

theme.useless_gap   = 0

-- layout icons
theme.layout_fairh      = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv      = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating   = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max        = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile       = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral     = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/default/layouts/dwindlew.png"
theme.layout_cornernw   = "/usr/share/awesome/themes/default/layouts/cornernww.png"
theme.layout_cornerne   = "/usr/share/awesome/themes/default/layouts/cornernew.png"
theme.layout_cornersw   = "/usr/share/awesome/themes/default/layouts/cornersww.png"
theme.layout_cornerse   = "/usr/share/awesome/themes/default/layouts/cornersew.png"


return theme
