-- Effortless wmii-style dynamic tagging.
loadrc("eminent", "eminent")

--{{{ Define Tags
context.layouts = {
    -- 1 - 3
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- 4 - 6
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- 7 - 9
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- 10
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral.dwindle,
}

awful.layout.layouts = context.layouts

-- for set tags.name to icon
theme.taglist_font = "FontAwesome 12"
context.tags = {
    -- How to input unicode symbol in Emacs?
    -- `C-x 8 Return f09b Return` -> 
    -- make sure you have the font installed which
    -- contained the unicode symbol
    names = {"", -- 1.web:  chrome (0xf268)
             "", -- 2.devlop: github (0xf09b)
             "", -- 3.docs: pdf (0xf1c1)
             "🎧", -- 4.media: television (0xf26c)  (0xf001)
             "", -- 5.term: command (0xf120)
             "", -- 6.files: folder (0xf07b)
             "", -- 7,
             "", -- 8, communication: wechat (f1d7)
             "", -- 9, devlop: linux (0xf17b)
    },

    layout = {context.layouts[1],
              context.layouts[1],
              context.layouts[9],
              context.layouts[7],
              context.layouts[8],
              context.layouts[4],
              context.layouts[4],
              context.layouts[4],
              context.layouts[1],
    },
}

-- {{{
context.buttons.tagbox = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({context.keys.modkey }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({context.keys.modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({context.keys.modkey}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({context.keys.modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, function(t) lain.util.tag_view_nonempty(-1) end),
    awful.button({}, 5, function(t) lain.util.tag_view_nonempty(1) end)
)
-- }}}

-- Bind all key numbers to tags.
-- be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    context.keys.global = awful.util.table.join(
        context.keys.global,
        -- View tag only.
        awful.key({context.keys.modkey}, "#" .. i + 9,
            function ()
                local tag = awful.screen.focused().tags[i]
                if tag then
                    tag:view_only()
                end
        end),
        -- Toggle tag.
        awful.key({context.keys.modkey, "Control"}, "#" .. i + 9,
            function ()
                local tag = awful.screen.focused().tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
        end),
        -- Move client to tag.
        awful.key({context.keys.modkey, "Shift"}, "#" .. i + 9,
            function ()
              if client.focus then
                  local tag = client.focus.screen.tags[i]
                  if tag then
                      client.focus:move_to_tag(tag)
                  end
              end
        end),
        -- Toggle tag.
        awful.key({context.keys.modkey, "Control", "Shift"}, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then
                        awful.client.toggletag(tag)
                    end
                end
        end)
    )
end


-- update root keys
root.keys(context.keys.global)
