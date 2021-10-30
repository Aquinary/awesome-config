local gears = require("gears")
local awful = require("awful")

require('widgets.app_menu')

tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                { raise = true }
            )
        end
    end),
    awful.button({ }, 3, function(c)
        if instance then
            if instance.visible == false then
                instance = create_menu(c)
            else
                instance.visible = false
                instance = nil
            end
        else
            instance = create_menu(c)

        end
    end),
    awful.button({ }, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

return taglist_buttons