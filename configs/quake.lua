local quake = loadrc("quake", "vbe/quake")

local quakeconsole = {}

-- each screen has it's own terminal
for s = 1, screen.count() do
    quakeconsole[s] = quake({terminal = context.cmd.terminal,
                             name = "quake_unique_instance" .. s,
                             height = 0.45,
                             width = 0.95,
                             screen = s})
end

local keydoc = loadrc("keydoc", "vbe/keydoc")
context.keys.global = awful.util.table.join(
    context.keys.global,

    keydoc.group("Misc"),
    awful.key({context.keys.altkey}, "Escape",
        function () quakeconsole[mouse.screen.index]:toggle() end,
        "Dropdown Terminal")
)

-- update root keys
root.keys(context.keys.global)
