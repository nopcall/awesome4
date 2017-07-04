-- require awful rule
awful.rules = require("awful.rules")

-- Rules
awful.rules.rules = {
    -- All clients will match this rule.
    {rule       = {},
     properties = {border_width     = beautiful.border_width,
                   border_color     = beautiful.border_normal,
                   focus            = awful.client.focus.filter,
                   raise            = true,
                   keys             = context.keys.client,
                   buttons          = context.buttons.client,
                   screen           = awful.screen.preferred,
                   placement        = awful.placement.no_overlap+awful.placement.no_offscreen,
                   size_hints_honor = false}
    },

    -- Add titlebars to normal clients and dialogs
    {rule_any = {type = {"dialog"}},
     properties = {titlebars_enabled = true}
    },

    {rule_any   = {class = {"Zeal", "GoldenDict", "copyq"}},
     properties = {floating = true,
                   sticky   = true,
                   border_width = beautiful.border_width_float},
     callback = function(c)
       c:geometry({width = 1200, height = 720})
       awful.placement.centered(c, nil)
     end
    },

    {rule_any   = {class = {"Google-chrome", "Firefox", "plugin-container"}},
     properties = {tag   = screen[1].tags[1]},
     callback   = function(c)
       -- All windows should be slaves, except the browser windows.
       if c.role ~= "browser" then
         awful.client.setslave(c)
       end
     end
    },

    {rule_any   = {class = {"SmartGit", "Emacs", "Gvim"}},
     properties = {tag   = screen[1].tags[2]}
    },

    {rule_any   = {class = {"Evince", "Wps", "Gimp", "Dia", "okular"}},
     properties = {tag   = screen[1].tags[3]}
    },


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
