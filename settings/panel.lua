local awful = require("awful")
local wibox = require("wibox")

function require_panel(s)
	-- Создаём панель слева
    if s.index == 1 then
        left_panel = awful.wibar({ position = "top", screen = s, height = 30, bg="#000000"})

       -- Определяем положение виджетов  
        left_panel:setup {
            layout = wibox.layout.stack,
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                    widgets.taglist,
                    widgets.separator,
                    widgets.tasklist,
                },
                nil,
                {
                    layout = wibox.layout.fixed.horizontal,
                    widgets.datetime,
                    widgets.separator,
                    --widgets.volume,
                    widgets.keyswitch,
                    widgets.logout,
                    widgets.layoutbox,
                    widgets.separator,
                },

            },
            {
                layout = wibox.layout.flex.horizontal,
                halign = 'center',
                widgets.titlebar.left,
            },
    }
    end

    if s.index == 2 then
        right_panel = awful.wibar({ position = "top", screen = s, height = 30, bg="#000000" })

        right_panel:setup {
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                widgets.taglist,
                widgets.separator,
                widgets.tasklist,

            },
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                widgets.systray,
                widgets.separator,
                widgets.layoutbox,
                widgets.separator,

            }
        },
        {
            layout = wibox.layout.flex.horizontal,
            halign = 'center',
            widgets.titlebar.right,
        },
    }
    end
end

	

   