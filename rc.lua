awful = require("awful")
beautiful = require("beautiful")
naughty = require("naughty")

-- custom lib path
package.path = package.path .. ';' ..
    awful.util.getdir("config") .. '/lib/?.lua;' ..
    awful.util.getdir("config") .. '/lib/?/init.lua;'

lain = require("lain")

-- auto focus
require("awful.autofocus")
-- custom functions
require("loadrc")

-- modkey = "Mod4"
altkey = "Mod1"
shiftkey = "Mod3"

context = {
    keys = {
        modkey = "Mod4",
        altkey = "Mod1",
        shiftkey = "Shift",
        global = {},
        client = {},
        tagbox = {},
    },
    buttons = {
        left = 1,               -- left click
        right = 3,              -- right click
        up = 4,                 -- scroll up
        down = 5,               -- scroll down
        global = {},
        client = {},
        tagbox = {},
        taskbox = {},
    },
    config = {
        weather = {
            city = 1816670,
            lang = "zh_CN",
        },
    },
    cmd = {
        terminal = "urxvtc",
        browser = "google-chrome"
    },
    guitools = {
      browser = "google-chrome",
      pdfviewer = "org.kde.okular",
      picviewer = "org.kde.gwenview",
      videoplayer = "vlc",
      filemanager = "org.kde.dolphin"
    },
    fonts = {},

    layouts = {},               -- layouts
    tags = {},                  -- tags
    menu = {},                  -- menu

    widgetbox = {},             -- widgets
--    layoutbox = {},             -- layoutbox
}

-- {{{ load configurations
loadrc("errors")        -- runtime error notify
loadrc("debug")         -- debug
loadrc("appearance")    -- appearance for both awesome and gtk applications
loadrc("desktop")       -- menu
loadrc("screen")
loadrc("keys")                  -- keys
loadrc("buttons")               -- buttons
loadrc("signals")       -- signals hack
loadrc("rules")         -- client rules
--loadrc("dtags")
loadrc("quake")         -- dropdown terminal
-- loadrc("droppad")       -- dropdown pad
loadrc("mime")          -- set mime default application
loadrc("start")         -- autostart applications
loadrc("xrandr")        -- multi screen
-- }}}
