-- require awful rule
awful.rules = require("awful.rules")

-- Rules
awful.rules.rules = {
    -- All clients will match this rule.
    {rule       = {},
     properties = {border_width     = beautiful.border_width,
                   border_color     = beautiful.border_normal,
                   focus            = awful.client.focus.filter,
                   keys             = context.keys.client,
                   buttons          = context.buttons.client,
                   screen           = awful.screen.preferred,
                   placement        = awful.placement.no_overlap+awful.placement.no_offscreen,
                   size_hints_honor = false}},
    {rule_any   = {class = {"Goldendict", "Zeal"}},
     properties = {floating = true,
                   sticky   = true}
    },

    {rule_any   = {class = {"Google-chrome", "Firefox", "plugin-container"}},
     properties = {tag   = screen[1].tags[1]},
     -- callback   =
     --     function(c)
     --         -- All windows should be slaves, except the browser windows.
     --         if c.role ~= "browser" then
     --             awful.client.setslave(c)
     --         end
     --     end
    },

    {rule_any   = {class = {"SmartGit", "Emacs", "Gvim"}},
     properties = {tag   = screen[1].tags[2]}
    },

    {rule_any   = {class = {"Evince", "Wps", "Gimp", "Dia"}},
     properties = {tag   = screen[1].tags[1]}
    },

    -- {rule_any   = {class = {"URxvt"}},
    --  properties = {tag   = tags[1][4]}},

    {rule_any   = {class = {"Hexchat"}},
     properties = {tag   = screen[1].tags[8]}
    },

    -- IDE
    {rule_any   = {class = {"jetbrains-studio", "jetbrains-pycharm-ce"}},
     properties = {tag   = screen[1].tags[9]}
    },

    -- Gimp main image window should be maximized
    {rule       = {class = "Gimp",
                   role  = "gimp-image-window"},
     properties = {maximized_horizontal = true,
                   maximized_vertical   = true}
    },
}
