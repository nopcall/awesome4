local keydoc = loadrc("keydoc", "vbe/keydoc")

local freedesktop = require("freedesktop")
-- Freedesktop Menu
context.menu = freedesktop.menu.build()

context.keys.global = awful.util.table.join(
    context.keys.global,

    keydoc.group("Misc"),
    awful.key({context.keys.modkey, "Shift"}, "m",
        function ()
            context.menu:show({keygrabber = true})
        end, "Show Menu")
)

-- update root keys
root.keys(context.keys.global)
