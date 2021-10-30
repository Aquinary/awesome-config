local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local beautiful = require("beautiful")

-- Создаём попап окно
local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 0)
    end,
    border_width = 0,
    border_color = beautiful.bg_focus,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}

local ICON_DIR = GET_FILE_PATH() .. 'icons/'
-- Создаём виджет-кнопу для панели задач
local widget = wibox.widget {
    {
        {
            image = ICON_DIR .. 'power_w.svg',
            resize = true,
            widget = wibox.widget.imagebox,
        },
        margins = 0,
        layout = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 0)
    end,
    widget = wibox.container.background,
}

-- Поведение виджета при нажатии на него
widget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                popup:move_next_to(mouse.current_widget_geometry)
            end
        end)
    )
)

widget = wibox.container.margin(widget, 2, 0, 4, 6)

local rows = { layout = wibox.layout.fixed.vertical }

-- Список пунктов и действий к ним
local menu_items = {
    { name = 'Выйти', icon_name = 'log-out.svg', command = function () awesome.quit() end },
    { name = 'Заблокировать', icon_name = 'lock.svg', command = function() awful.spawn.with_shell("i3lock") end },
    { name = 'Перезагрузка', icon_name = 'refresh-cw.svg', command = function() awful.spawn.with_shell("reboot") end },
    { name = 'Сон', icon_name = 'moon.svg', command = function() awful.spawn.with_shell("systemctl suspend") end },
    { name = 'Выключение', icon_name = 'power.svg', command = function() awful.spawn.with_shell("shutdown now") end },
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
                spacing = 5,
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

return widget