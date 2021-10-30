local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ICON_DIR = GET_FILE_PATH() .. 'icons/'

function create_menu(c)
    -- Создаём попап окно
    local popup = awful.popup {
        ontop = true,
        visible = true,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0)
        end,
        border_width = 0,
        border_color = beautiful.bg_focus,
        maximum_width = 150,
        minimum_width = 150,
        offset = { y = 5 },
        hide_on_right_click = true,
        widget = {}
    }

    local rows = { layout = wibox.layout.fixed.vertical }

    -- Список пунктов и действий к ним
    local menu_items = {

        { name = 'Закрыть', icon_name = '', command = function () c:kill() end },
        { name = 'Переместить', icon_name = '', command = function () c:kill() end },
    }

    local tags_items = {

    }
    -- Циклично редактируем виджеты
    for _, item in ipairs(menu_items) do
        local row = wibox.widget {
            {
                {
                    {
                        image = ICON_DIR .. item.icon_name,
                        resize = false,
                        widget = wibox.widget.imagebox
                    },
                    {
                        text = item.name,
                        font = beautiful.font,
                        widget = wibox.widget.textbox
                    },
                    spacing = 3,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = 8,
                layout = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            widget = wibox.container.background
        }

        -- Устанавливает фон при наведении курсором мыши на элементе
        row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
        row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

        -- Меняет курсор на pointer
        local old_cursor, old_wibox
        row:connect_signal("mouse::enter", function()
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand1"
        end)
        row:connect_signal("mouse::leave", function()
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end)

        -- Выполняет непосредственное действие при клике
        row:buttons(awful.util.table.join(awful.button({}, 1, function()
            popup.visible = not popup.visible
            item.command()
        end)))

        table.insert(rows, row)
    end




    popup:setup(rows)

    popup_unfocused(popup)
    popup:move_next_to(mouse.current_widget_geometry)

    return popup
end


return {
    create = function()
        -- Создаём попап окно
        local popup = awful.popup {
            ontop = false,
            visible = false,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 0)
            end,
            border_width = 0,
            border_color = beautiful.bg_focus,
            maximum_width = 150,
            minimum_width = 150,
            offset = { y = 5 },
            hide_on_right_click = true,
            widget = {}
        }

        return popup
    end,
    enable = function(popup)
        local rows = { layout = wibox.layout.fixed.vertical }

        -- Список пунктов и действий к ним
        local menu_items = {

            { name = 'Закрыть', icon_name = '', command = function () c:kill() end },
        }

        -- Циклично редактируем виджеты
        for _, item in ipairs(menu_items) do
            local row = wibox.widget {
                {
                    {
                        {
                            image = ICON_DIR .. item.icon_name,
                            resize = false,
                            widget = wibox.widget.imagebox
                        },
                        {
                            text = item.name,
                            font = beautiful.font,
                            widget = wibox.widget.textbox
                        },
                        spacing = 3,
                        layout = wibox.layout.fixed.horizontal
                    },
                    margins = 8,
                    layout = wibox.container.margin
                },
                bg = beautiful.bg_normal,
                widget = wibox.container.background
            }

            -- Устанавливает фон при наведении курсором мыши на элементе
            row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
            row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

            -- Меняет курсор на pointer
            local old_cursor, old_wibox
            row:connect_signal("mouse::enter", function()
                local wb = mouse.current_wibox
                old_cursor, old_wibox = wb.cursor, wb
                wb.cursor = "hand1"
            end)
            row:connect_signal("mouse::leave", function()
                if old_wibox then
                    old_wibox.cursor = old_cursor
                    old_wibox = nil
                end
            end)

            popup.visible = true
            popup.ontop = true
            -- Выполняет непосредственное действие при клике
            row:buttons(awful.util.table.join(awful.button({}, 1, function()
                popup.visible = not popup.visible
                --item.command()
            end)))

            table.insert(rows, row)
        end




        popup:setup(rows)

        popup_unfocused(popup)
        popup:move_next_to(mouse.current_widget_geometry)

    end
}
