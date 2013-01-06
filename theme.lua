---------------------------
-- Default awesome theme --
---------------------------
theme = {}
--theme.confdir = awful.util.getdir("config" .. "/home/eschaton/.icons/pixel/icons_18x18/png/blue"

theme.font          = "bahamas 9"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#F87217"
theme.bg_minimize   = "#000000"

theme.fg_normal     = "#F87217"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#F87217"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#222222"
theme.border_marked = "#222222"
theme.bg_em = "#5a5a5a"
theme.bg_systray = theme.bg_normal

theme.fg_widget = "#908884"
theme.fg_center_widget = "#636363"
theme.fg_end_widget = "#1a1a1a"
theme.bg_widget = "#2a2a2a"
theme.border_widget = "#3F3F3F"
-- {{{ Titlebars

theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"

-- }}}
theme.widget_net = "~/.config/awesome/icons/net_down_01.svg"
theme.widget_netup = "~/.config/awesome/icons/net_up_01.svg"
theme.widget_cpu = "~/.config/awesome/icons/cpu.svg"
theme.widget_mem = "~/.config/awesome/icons/mem.svg"
theme.widget_mail = "~/.config/awesome/icons/mail.svg"
theme.widget_pac = "~/.config/awesome/icons/pacman.svg"
theme.widget_pacnew = "~/.config/awesome/icons/pacnew.svg"
theme.widget_mpd = "~/.config/awesome/icons/note.png"
theme.widget_weather = "~/.config/awesome/icons/weather.svg"
theme.widget_batfull = "~/.config/awesome/icons/batt_full.svg"
theme.widget_ac = "~/.config/awesome/icons/ac.svg"
theme.widget_wifi = "~/.config/awesome/icons/wifi_03.svg"
theme.widget_vol = "~/.config/awesome/icons/spkr_01.svg"
theme.widget_temp = "~/.config/awesome/icons/temp.svg"
theme.widget_play = "~/.config/awesome/icons/play.svg"
theme.widget_pause = "~/.config/awesome/icons/pause.svg"
theme.widget_stop = "~/.config/awesome/icons/stop.svg"
theme.widget_prev = "~/.config/awesome/icons/prev.svg"
theme.widget_next = "~/.config/awesome/icons/next.svg"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/eschaton/.config/awesome/themes/grey/normal/005_56.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/eschaton/.config/awesome/icons/actions/player_play.svg"
theme.menu_height = "15"
theme.menu_width  = "105"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper = "/home/eschaton/.config/awesome/themes/default/field.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/eschaton/.config/awesome/themes/grey/normal/005_58.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/home/eschaton/.config/awesome/icons/places/gnome-fs-desktop.svg"


return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
