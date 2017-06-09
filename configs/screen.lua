-- load necessary layaout components with layout dir prefix.
loadrc("component/tags")
loadrc("component/tasks")
loadrc("component/widgets")

--{{{ require wibox
local wibox = require("wibox")
--}}}

-- per screen setting
function init_after_screen_connect(s)
    -- each screen's tag table
    awful.tag(context.tags.names, s, context.tags.layout)

    -- Create a taglist widget
    s.tagbox = awful.widget.taglist(s,
                                    awful.widget.taglist.filter.all,
                                    context.buttons.tagbox)

    -- Create a task box
    s.taskbox = awful.widget.tasklist(s,
                                      awful.widget.tasklist.filter.currenttags,
                                      context.buttons.taskbox)
    -- Create a promptbox
    s.promptbox = awful.widget.prompt()

    -- layoutbox
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(awful.util.table.join(
                            awful.button({}, 1, function () awful.layout.inc(1) end),
                            awful.button({}, 3, function () awful.layout.inc(-1) end),
                            awful.button({}, 4, function () awful.layout.inc(1) end),
                            awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create the upper wibox
    s.panel_top = awful.wibar({position = "top", screen = s, height = 20})

    s.panel_top:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.tagbox,
            s.promptbox,
            sep,
        },
        s.taskbox,
        {
            layout = wibox.layout.fixed.horizontal,
            sep,
            wibox.widget.systray(),
            context.widgetbox,
            s.layoutbox,
        },
    }
end

-- hot plug screen
awful.screen.connect_for_each_screen(function(s) init_after_screen_connect(s) end)
