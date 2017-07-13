-- {{{ Signals

-- signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules
local gears = require("gears")
local wibox = require("wibox")
client.connect_signal(
  "request::titlebars",
  function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
      awful.button({}, 1, function()
          client.focus = c
          c:raise()
          awful.mouse.client.move(c)
      end),
      awful.button({}, 3, function()
          client.focus = c
          c:raise()
          awful.mouse.client.resize(c)
      end)
    )

    awful.titlebar(c):setup
    {
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
        { -- Title
          align  = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      { -- Right
        -- awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.minimizebutton(c),
        -- awful.titlebar.widget.stickybutton(c),
        -- awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.align.horizontal
    }

    -- Hide the menubar if we are not floating
    if c.type ~= "dialog" or not c.floating then
      awful.titlebar.hide(c)
    end

  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
            client.focus = c
        end
    end
)

client.connect_signal(
    "focus",
    function(c)
        -- focus windows should not transparent
        c.border_color = beautiful.border_focus
        c.opacity = 1
    end
)

client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
        c.opacity = 0.70
    end
)

screen.connect_signal(
    "arrange",
    function (s)
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))
        -- Fine grained borders and floaters control
        if #clients > 0 then
            -- Floaters always have borders
            for _, c in pairs(clients) do
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width_float

                -- No borders with only one visible client
                elseif #clients == 1 or layout == "max" then
                    c.border_width = 0
                else
                    c.border_width = beautiful.border_width
                end

            end
        end
    end
)
-- }}}
