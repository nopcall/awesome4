-- require wibox
local wibox = require("wibox")

theme.wibox_bg_darker = beautiful.colors.base3

-- {{{ Wibox
markup = lain.util.markup

-- seperator
sep = wibox.widget.textbox(" ")
-- darker background seperator
sepd = wibox.container.background()
sepd:set_widget(sep)
sepd:set_bg(theme.wibox_bg_darker)

--{{{
textclock = wibox.widget.textclock(" %H:%M ")

-- calendar
calendar = lain.widget.calendar({
    --cal = "cal --color=always",
    attach_to = { textclock },
    notification_preset = {
        font = "Fira Mono",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
weather = lain.widget.weather({
        city_id = context.config.weather.city, -- placeholder (London)
        lang = context.config.weather.lang,
        notification_preset = { font = "Fira Mono", fg = theme.fg_normal },
        weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
        settings = function()
            descr = weather_now["weather"][1]["description"]:lower()
            units = math.floor(weather_now["main"]["temp"])
            widget:set_markup(markup.fontfg(theme.font, "#eca4c4", " " .. descr .. " @ " .. units .. "°C "))
        end
})

-- mem
memicon = wibox.widget.imagebox(theme.widget_mem)
mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "mem:" .. mem_now.used .. "MB "))
    end
})
-- CPU
cpuicon = wibox.widget.imagebox(theme.widget_cpu)
cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, "cpu:" .. cpu_now.usage .. "%"))
    end
})
-- Coretemp (lain, average)
tempicon = wibox.widget.imagebox(theme.widget_temp)
temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, "/" .. coretemp_now .. "°C "))
    end
})
-- Net
neticon = wibox.widget.imagebox(theme.widget_net)
net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#87af5f", "  " .. net_now.received .. "  " .. net_now.sent .. " "))
    end
})

-- volume
volume = lain.widget.alsa({
        settings = function()
            if volume_now.status == "off" then
                volume_now.level = " " .. volume_now.level .. "M"
                -- elseif tonumber(volume_now.level) >= 50 then
                --     -- volume_now.level = " " .. volume_now.level
                --     volume_now.level = " " .. volume_now.level
            else
                -- volume_now.level = " " .. volume_now.level
                volume_now.level = " " .. volume_now.level
            end
            -- widget:set_markup(markup("#7493d2", " " .. v .. " "))
            widget:set_markup(" " .. volume_now.level .. " ")
        end
})
context.keys.global = awful.util.table.join(
    context.keys.global,
    -- ALSA volume control
    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volume.channel))
            volume.update()
    end),
    awful.key({}, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volume.channel))
            volume.update()
    end),
    awful.key({}, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer set %s toggle", volume.channel))
            volume.update()
    end),
    awful.key({altkey, "Control"}, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volume.channel))
            volume.update()
        end, "Max Volume")
)
root.keys(context.keys.global)

context.widgetbox = {layout = wibox.layout.fixed.horizontal, weather.widget, net.widget, cpu.widget, temp.widget, mem.widget, volume.widget, textclock}
--}}}
