function require_widgets(s)
    local awful = require("awful")
    local wibox = require("wibox")
    local gears = require("gears")
    local beautiful = require("beautiful")


    widgets = {}


    --[[ Виджет разделения других виджетов ]]--
    widgets.separator = wibox.widget {
        orientation = 'vertical',
        forced_height = 10,
        forced_width = 10,
        thickness = 0,
        widget = wibox.widget.separator,
    }

    --[[ Виджет списка тегов ]]--

    widgets.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style = {
            bg_normal = "#000000",
            bg_focus = "#212529",
            fg_minimize = "#111111" .. "50",
            bg_minimize = "#000000",
            bg_urgent = "#FBE698" .. "30",
        },
        layout   = {
            spacing = 0,
            layout  = wibox.layout.fixed.horizontal
        },
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.flex.horizontal,
                },
                top = 2,
                left = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
    }


    --[[ Виджет списка запущенных приложений на текущем теге --]]
    widgets.tasklist = wibox.widget {
        {
            widget = awful.widget.tasklist {
                screen = s,
                filter  = awful.widget.tasklist.filter.currenttags,
                buttons = tasklist_buttons,
                style = {
                    bg_normal = "#000000",
                    bg_focus = "#212529",
                    fg_minimize = "#111111" .. "50",
                    bg_minimize = "#000000",
                    bg_urgent = "#FBE698" .. "30",
                },
                layout = {
                    layout = wibox.layout.fixed.horizontal,
                },
                widget_template = {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox
                        },
                        left = 7,
                        right = 6,
                        top = 6,
                        bottom = 6,
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = wibox.container.background,
                },
            },
        },
        widget = wibox.container.place
    }

    widgets.titlebar = require('widgets.titlebar')
    -- Индикатор раскладки и переключение языка
    if s.index == 1 then
        widgets.keyswitch = require('widgets.keyswitch')

        --widgets.keyboard = awful.widget.keyboardlayout()
        -- Индикатор уровня громкости
        widgets.volume = require("awesome-wm-widgets.volumearc-widget.volumearc")

        widgets.datetime = wibox.widget.textclock('%H:%M')

        -- Выход из системы
        widgets.logout = require("widgets.logout")

    end

    -- Индикатор стиля отображения рабочего стола
    local layoutbox = awful.widget.layoutbox(s)

    -- Переключение стиля кликом по иконке
    layoutbox:buttons(gears.table.join
    (
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end))
    )

    -- Центрируем по середине и делаем отступ вверх
    widgets.layoutbox = wibox.container.margin(layoutbox, 3, 6, 6, 7)

    -- Системный трей
    beautiful.bg_systray = "#000000"

    beautiful.systray_icon_spacing = '3'
    widgets.systray = wibox.widget {
        {
            {
                screen=screen[2],
                widget = wibox.widget.systray(),
                base_size = 16,
            },
            left = 7, right = 7,
            widget = wibox.container.margin
        },
        widget = wibox.container.place
    }

    return widgets
end
