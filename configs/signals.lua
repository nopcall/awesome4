-- {{{ Signals

-- signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function (c, startup)
        -- Put windows in a smart way, only if they does not set an initial position.
        if not startup then
            if not c.size_hints.user_position
                and
                not c.size_hints.program_position
            then
                awful.placement.no_overlap(c)
                awful.placement.no_offscreen(c)
            end
            c:raise()
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
        -- No border for maximized clients
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_width = 0
        else
--            c.border_color = beautiful.border_normal

            c.border_color = beautiful.border_focus
        end

        -- focus windows should not transparent
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
                -- No borders with only one humanly visible client
                if layout == "max" and c.type ~= "DIALOG" then
                    -- client in max layout tag should not have border unless it's a dialog window
                    c.border_width = 0
                elseif c.floating or layout == "floating" then
                    -- floating client or flotaing tag have border
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then
                    -- only a client should be maximenized and no border
                    clients[1].border_width = 0

                    -- if layout ~= "max" then
                    --     -- awful.client.moveresize(0, 0, 2, 0, clients[1])
                    --     clients[1]:relative_move(0, 0, 2, 0)
                    -- end

                else
                    c.border_width = beautiful.border_width
                end

                -- goldendict and zeal
                -- dialog box should have a special border
                if (c.type == "DIALOG") or
                    (c.class == "GoldenDict") or
                    (c.class == "Zeal")
                then
                    c.width = 800
                    c.height = 600
                    c.border_width = 1
                end

            end
        end
    end
)
-- }}}
