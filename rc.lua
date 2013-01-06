-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local bashets = require("bashets")
--local wi = require("wi")

-- {{{ Error handling
awful.util.spawn_with_shell("xcompmgr &")
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/eschaton/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
browser = "dwb"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
filemanager = terminal .. " -e ranger"
mutt = terminal .. " -e mutt -y"
wyrd= terminal .. "-e wyrd -y"
nwn = "/home/eschaton/Games/NWN/nwn/nwnshort"
koh = "wine /home/eschaton/Games/KOH/KoH.exe"
diablo = "wine /home/eschaton/Games/Diablo/Game.exe"
morrowind = "/home/eschaton/Games/Morrowind/morrowind"
disciples = "wine /home/eschaton/Games/disciples2/discipl2.exe"
sparan = "wine /home/eschaton/Games/SpaRan/rangers.exe"
civ4 =  "/home/eschaton/Games/Civ4/civ4"
wine = "wine"
arcanum = "/home/eschaton/Games/Arcanum/New"
sacred = "/home/eschaton/Games/Sacred Underworld/sacred"
toee = "/home/eschaton/Games/TOEE/toee"
tg2r = "/home/eschaton/Games/TG2R/tg2r"
konung = "/home/eschaton/Games/Konning/Konung"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
   tags[s] = awful.tag({ "[1]", "[2]", "[3]", "[4]" }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "lock", "xscreensaver-command -activate" },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

myapps = {
   { "Browser", "dwb" },
   { "LibreOffice", "libreoffice" },
   { "skype", "skype" }
}
mygames = {
   { "Arcanum", arcanum },
   { "Neverwinter Nights", nwn },
   { "Knights Of Honor", koh },
   { "Konung", konung },
   { "Diablo", diablo },
   { "Cave Story", "doukutsu"},
   { "Morrowind", morrowind },
   { "Space Rangers", sparan },
   { "Sacred", sacred},
   { "Temple of Elemental Evil", toee},
   { "The Guild II", tg2r},
   { "Disciples II", disciples },
   { "Civilization IV", civ4 },
   { "Mari0", "mari0" }
}

mymainmenu = awful.menu.new({ items = { 
                                        { "Editor", terminal .. " -e " .. editor },
                                        { "File Manager", filemanager },
                                        { "Apps", myapps, beautiful.awesome_icon },
  				{ "Games", mygames, beautiful.awesome_icon },
                                        { "awesome", myawesomemenu, beautiful.awesome_icon }
                                       }
                             })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()
-- Various widgets
--{{
slash = wibox.widget.textbox()
slash:set_text(" / ")
space = wibox.widget.textbox()
space:set_text(" ")
tab = wibox.widget.textbox()
tab:set_text("      ")
cpuico = wibox.widget.imagebox()
cpuico:set_image(beautiful.widget_cpu)
memico = wibox.widget.imagebox()
memico:set_image(beautiful.widget_mem)
netupico = wibox.widget.imagebox()
netupico:set_image(beautiful.widget_netup)
netdwnico = wibox.widget.imagebox()
netdwnico:set_image(beautiful.widget_net)
volspace = wibox.widget.textbox()
volspace:set_text(" ")
tempico = wibox.widget.imagebox()
tempico:set_image(beautiful.widget_temp)
weathico = wibox.widget.imagebox()
weathico:set_image(beautiful.widget_weather)
--Gmail checker
--{{{
mailico = wibox.widget.imagebox()
mailico:set_image(beautiful.widget_mail)
gmailwidget = wibox.widget.textbox()
gmail_t = awful.tooltip({ objects = { gmailwidget },})

vicious.register(gmailwidget, vicious.widgets.gmail,
                function (widget, args)
                    gmail_t:set_text(args["{subject}"])
                    return " "..args["{count}"]
                 end, 60)
		 --}}}
		 --Simple thermal widget
term = wibox.widget.textbox()
vicious.register(term, vicious.widgets.thermal, " $1°C", 19, "thermal_zone0")
--term = wibox.widget.textbox()
--vicious.register(term, vicious.widgets.thermal,
   --                 31, "thermal_zone0")
--mail:set_text("asd")
-- }}
-- {{{ PROCESSOR
-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)
-- Core 0 freq
--cpufreq = wibox.widget.textbox()
--vicious.register(cpufreq, vicious.widgets.cpuinf, function(widget, args)
 --  return string.format("<span color='" .. beautiful.fg_em .. "'>cpu</span>%1.1fGHz", args["{cpu0 ghz}"])
--end, 3000)
-- Core 0 %
cpupct0 = wibox.widget.textbox()
cpupct0.fit = function(box,w,h)
  local w,h = wibox.widget.textbox.fit(box,w,h) return math.max(20,w),h
end
vicious.register(cpupct0, vicious.widgets.cpu, "$2%", 2)
-- Core 1 %
cpupct1 = wibox.widget.textbox()
cpupct1.fit = function(box,w,h)
  local w,h = wibox.widget.textbox.fit(box,w,h) return math.max(20,w),h
end
vicious.register(cpupct1, vicious.widgets.cpu, "$3%", 2)
-- }}}
-- {{{ MEMORY
-- Cache
vicious.cache(vicious.widgets.mem)
-- Ram %
mempct = wibox.widget.textbox()
mempct.width = 20
vicious.register(mempct, vicious.widgets.mem, "$1%", 5)
-- }}}
-- {{{ NETWORK
-- Cache
vicious.cache(vicious.widgets.net)
-- Up speed
upwidget = wibox.widget.textbox()
upwidget.fit = function(box,w,h)
  local w,h = wibox.widget.textbox.fit(box,w,h) return math.max(40,w),h
end
vicious.register(upwidget, vicious.widgets.net, "${wlan0 up_kb}", 2)
-- Down speed
downwidget = wibox.widget.textbox()
downwidget.fit = function(box,w,h)
  local w,h = wibox.widget.textbox.fit(box,w,h) return math.max(40,w),h
end
vicious.register(downwidget, vicious.widgets.net, "${wlan0 down_kb}", 2)
-- }}}
-- {{{ PACMAN
-- Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)

-- Upgrades
pacwidget = wibox.widget.textbox()
vicious.register(pacwidget, vicious.widgets.pkg, function(widget, args)
  if args[1] > 0 then
    pacicon:set_image(beautiful.widget_pacnew)
  else
    pacicon:set_image(beautiful.widget_pac)
  end

  return args[1]
end, 1801, "Arch S") -- Arch S for ignorepkg
-- }}}
-- {{{ BATTERY
-- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_batfull)

-- Charge %
batpct = wibox.widget.textbox()
vicious.register(batpct, vicious.widgets.bat, function(widget, args)
  bat_state  = args[1]
  bat_charge = args[2]
  bat_time   = args[3]

  if args[1] == "-" then
    baticon:set_image(beautiful.widget_batfull)
  else
    baticon:set_image(beautiful.widget_ac)
  end

  return args[2] .. "%"
end, nil, "BAT0")

-- Buttons
function popup_bat()
  local state = ""
  if bat_state == "↯" then
    state = "Full"
  elseif bat_state == "↯" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  elseif bat_state == "⌁" then
    state = "Not charging"
  else
    state = "Unknown"
  end

  naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
    " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end
batpct:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batpct:buttons())
-- }}}
-- {{{ WEATHER
weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather, " ${tempc}°C",
  1501, "LBSF")
 --function popup_weather()
 
weather:buttons(awful.util.table.join(awful.button({ }, 1, popup_weather)))
weathico:buttons(weather:buttons())

-- }}}

-- {{{ VOLUME
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

-- Volume %
volpct = wibox.widget.textbox()
vicious.register(volpct, vicious.widgets.volume, "$1%", nil, "Master")

-- Buttons
volicon:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function() awful.util.spawn_with_shell("amixer -q set Master toggle") end),
  awful.button({ }, 4,
    function() awful.util.spawn_with_shell("amixer -q set Master 3+% unmute") end),
  awful.button({ }, 5,
    function() awful.util.spawn_with_shell("amixer -q set Master 3-% unmute") end)
))
volpct:buttons(volicon:buttons())
volspace:buttons(volicon:buttons())
-- }}}
-- Create a wibox for each screen and add it
mywibox = {}
mybwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(weathico)
    right_layout:add(weather)
    right_layout:add(space)
    right_layout:add(volicon)
    right_layout:add(volpct)
    --right_layout:add(volspace)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
   
    mywibox[s]:set_widget(layout)
--- My bottom wibox
    mybwibox[s] = awful.wibox({ position = "bottom", screen = s })
    
    local left_mybwibox = wibox.layout.fixed.horizontal()
    --left_mybwibox:add(cpufreq)
    left_mybwibox:add(baticon)
    left_mybwibox:add(batpct)
    left_mybwibox:add(tab)
    left_mybwibox:add(cpuico)
    left_mybwibox:add(space)
    left_mybwibox:add(cpupct0)
    left_mybwibox:add(slash) 
    left_mybwibox:add(cpupct1)
    left_mybwibox:add(tab)
    left_mybwibox:add(memico)
    left_mybwibox:add(space)
    left_mybwibox:add(mempct)
    left_mybwibox:add(tab)
    left_mybwibox:add(tempico)
    left_mybwibox:add(term)
    left_mybwibox:add(tab)
    

    local right_mybwibox = wibox.layout.fixed.horizontal()
    right_mybwibox:add(pacicon)
    right_mybwibox:add(pacwidget)
    right_mybwibox:add(tab)
    right_mybwibox:add(mailico)
    right_mybwibox:add(gmailwidget)
    right_mybwibox:add(tab)
    right_mybwibox:add(netupico)
    right_mybwibox:add(space)
    right_mybwibox:add(upwidget)
    right_mybwibox:add(netdwnico)
    right_mybwibox:add(space)
    right_mybwibox:add(downwidget)
    
    local mybwibox_layout = wibox.layout.align.horizontal()
    mybwibox_layout:set_left(left_mybwibox)
    mybwibox_layout:set_middle(mytasklist[s])
    mybwibox_layout:set_right(right_mybwibox)

    mybwibox[s]:set_widget(mybwibox_layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
function run_once(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end
do
  local cmds = 
  { 
   -- run_once("conky"),
    run_once("mutt"),
    run_once("xrdb ~/.Xresources")
    --and so on...
  }

  for _,i in pairs(cmds) do
    awful.util.spawn(i)
  end
end
