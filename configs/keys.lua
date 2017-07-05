local keydoc = loadrc("keydoc", "vbe/keydoc")

-- {{{ Key bindings
context.keys.global = awful.util.table.join(
    context.keys.global,

    keydoc.group("Layout manipulation"),
    -- Tag browsing
    awful.key({context.keys.modkey}, "Left", awful.tag.viewprev, "Jump to Left tag"),
    awful.key({context.keys.modkey}, "Right", awful.tag.viewnext, "Jump to Right tag"),
    awful.key({context.keys.modkey}, "Escape", awful.tag.history.restore, "Jump to Last tag"),
    -- Non-empty tag browsing
    awful.key({context.keys.modkey}, "q",
        function ()
            lain.util.tag_view_nonempty(-1)
        end, "Jump to Left None Empty tag"),
    awful.key({context.keys.modkey}, "w",
        function ()
            lain.util.tag_view_nonempty(1)
        end, "Jump to Right None Empty tag"),

    keydoc.group("Focus"),
    -- Default client focus
    awful.key({altkey,}, "Tab",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end, "Focus to Right Client in TaskList"),
    awful.key({altkey, "Shift"}, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end, "Focus to Left client in TaskList"),

    -- By direction client focus
    awful.key({context.keys.modkey}, "j",
        function ()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end, "Focus to Down Client"),
    awful.key({context.keys.modkey}, "k",
        function ()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end, "Focus to Up Client"),
    awful.key({context.keys.modkey}, "h",
        function ()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end, "Focus to Left Client"),
    awful.key({context.keys.modkey}, "l",
        function ()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end, "Focust to Right Client"),

    awful.key({context.keys.modkey, "Shift"}, "j",
        function ()
            awful.client.swap.byidx(1)
        end, "Swap Client to Next Client"),
    awful.key({context.keys.modkey, "Shift"}, "k",
        function ()
            awful.client.swap.byidx(-1)
        end, "Swap Client to Previous Client"),
    awful.key({context.keys.modkey, "Control"}, "j",
        function ()
            awful.screen.focus_relative(1)
        end, "Focus to Next Relative Screen"),
    awful.key({context.keys.modkey, "Control"}, "k",
        function ()
            awful.screen.focus_relative(-1)
        end, "Focus to Previous Relative Screen"),
    awful.key({context.keys.modkey}, "u", awful.client.urgent.jumpto, "Jumpto Urgent Client"),
    awful.key({context.keys.modkey}, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, "Focus to Last Client"),
    awful.key({context.keys.modkey, "Shift"}, "Tab", function ()
        -- If you want to always position the menu on the same place set coordinates
        awful.menu.menu_keys.down = { "Down", "Alt_L" }
        awful.menu.clients({theme = { width = 250 }}, { keygrabber=true, coords={x=525, y=330} })
    end),

    keydoc.group("Window-specific bindings"),
    awful.key({context.keys.modkey, "Control"}, "n", awful.client.restore, "Restore Minimize Client"),

    keydoc.group("Layout manipulation"),
    -- Layout manipulation
    awful.key({altkey, "Shift"}, "l", function () awful.tag.incmwfact(0.05) end,
        "Tag incmwfact 0.05"),
    awful.key({altkey, "Shift"}, "h", function () awful.tag.incmwfact(-0.05) end,
        "Tag decmwfact 0.05"),
    awful.key({context.keys.modkey, "Shift"}, "l", function () awful.tag.incnmaster(-1) end,
        "Tag decnmaster 1"),
    awful.key({context.keys.modkey, "Shift"}, "h", function () awful.tag.incnmaster(1) end,
        "Tag incnmmaster 1"),
    awful.key({context.keys.modkey, "Control"}, "l", function () awful.tag.incncol(-1) end,
        "Tag decncol 1"),
    awful.key({context.keys.modkey, "Control"}, "h", function () awful.tag.incncol(1) end,
        "Tag Incncol 1"),
    -- Layout change
    awful.key({context.keys.modkey}, "space",  function () awful.layout.inc(1) end,
        "Next Layout"),
    awful.key({context.keys.modkey, "Shift"}, "space", function () awful.layout.inc(-1) end,
        "Previous Layout"),
    -- Show/Hide Wibox
    awful.key({context.keys.modkey}, "b", function ()
            awful.screen.focused().panel_top.visible = not awful.screen.focused().panel_top.visible
                             end, "Toggle Panel"),

    keydoc.group("Misc"),
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({}, "Print",
        function ()
            awful.spawn.with_shell(
                "scrot -d 1 -q 100 '%Y-%m-%d_$wx$h.png' -e 'mv $f /tmp/'" ..
                    " && notify-send 'ScreenCaptured'")
        end, "Screenshot"),
    awful.key({context.keys.modkey}, "Print", function () os.execute("~/bin/pastimg.pl") end, "Screenshot"),
    awful.key({}, "XF86ScreenSaver",
        function ()
            awful.spawn("xss-lock.sh lock")
        end, "Lock Screen"),
    awful.key({ context.keys.modkey, }, "Delete",
        function ()
            awful.spawn("xss-lock.sh lock")
        end, "Lock Screen"),
    awful.key({context.keys.modkey}, "F1", keydoc.display, "Show keydoc"),

    awful.key({context.keys.modkey}, "Return", function () awful.spawn(context.cmd.terminal) end,
        "Start Terminal"),

    -- Clipboard
    awful.key({context.keys.modkey}, "c", function () os.execute("xsel -p -o | xsel -i -b") end,
        "Copy to Clipboard"),
    -- quickly move mouse to a safe position
    awful.key({context.keys.modkey}, "o",
        function ()
            awful.spawn.with_shell("xdotool mousemove 10 750 click --clearmodifiers 1")
        end, "Move mouse point to bottom left then click"),

    -- Prompt
    awful.key({context.keys.modkey}, "r", function () awful.screen.focused().promptbox:run() end,
        "Promot Command Box"),

    awful.key({altkey, "Control", "Shift"}, "r",
        function ()
            awful.spawn("dmenu_run -i -p 'Run command:' -nb '" ..
                                 beautiful.bg_normal ..
                                 "' -nf '" .. beautiful.fg_normal ..
                                 "' -sb '" .. beautiful.bg_focus  ..
                                 "' -sf '" .. beautiful.fg_focus  .. "'")
        end, "Dmenu Launcher"),
    awful.key({altkey, "Control"}, "r",
        function ()
            awful.spawn("j4-dmenu-desktop" ..
                                 " --display-binary" ..
                                 " [--dmenu='dmenu -i']" ..
                                 " [--term='xterm']")
        end, "j4 Dmenu launcher"),
    awful.key({context.keys.modkey}, "x",
        function ()
            awful.prompt.run({prompt = "Run Lua code: "},
                awful.screen.focused().promptbox.widget,
                awful.util.eval, nil,
                awful.util.getdir("cache") .. "/history_eval")
        end, "Lua code command box"),
    awful.key({context.keys.modkey, "Control"}, "r", awesome.restart, "Restart Awesome"),
    awful.key({context.keys.modkey, "Control", "Shift"}, "q", awesome.quit, "Quit Awesome")
)

context.keys.client = awful.util.table.join(
    keydoc.group("Window-specific bindings"),
    awful.key({context.keys.modkey}, "f", function(c) c.fullscreen = not c.fullscreen end,
        "Fullscreen"),
    awful.key({context.keys.modkey, "Shift"}, "c", function (c) c:kill() end, "Kill client"),
    awful.key({context.keys.modkey, "Control"}, "space", awful.client.floating.toggle,
        "Toggle Floating mode of current client"),
    awful.key({context.keys.modkey, "Control"}, "Return",
        function (c)
            c:swap(awful.client.getmaster())
        end, "SwapToMaster"),
    awful.key({context.keys.modkey, "Shift"}, "o", function(c) c:move_to_screen() end, "Move to Screen"),
    awful.key({context.keys.modkey, "Shift"}, "t", function (c) c.ontop = not c.ontop end,
        "Make Screen on Top"),
    awful.key({context.keys.modkey}, "t", awful.titlebar.toggle),
    awful.key({context.keys.modkey}, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, "Minimize current Client"),
    awful.key({context.keys.modkey}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end, "Maximize Current Client")
)

-- Set keys
root.keys(context.keys.global)
-- }}}
