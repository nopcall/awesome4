
-- {{{ Mouse Bindings
context.buttons.global = awful.util.table.join(
    context.buttons.global,
    -- awful.button({}, 3, function () mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewprev),
    awful.button({}, 5, awful.tag.viewnext)
)

root.buttons(context.buttons.global)
-- }}}

context.buttons.client = awful.util.table.join(
    awful.button({}, 1, function (c) client.focus = c; c:raise() end),
    awful.button({altkey}, 1, awful.mouse.client.move),
    awful.button({altkey}, 3, awful.mouse.client.resize)
)
-- }}}
