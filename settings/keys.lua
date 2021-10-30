local gears = require("gears")
local awful = require("awful")
local menubar = require("menubar")

modkey = 'Mod4'

event = {
    root = {},
    client = {}
}

event.client.keys = gears.table.join(
        awful.key({ modkey,           }, "f",
                function (c)
                    c.fullscreen = not c.fullscreen
                    c:raise()
                end,
                {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey }, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
                function (c)
                    -- The client currently has the input focus, so it cannot be
                    -- minimized, since minimized clients can't have the focus.
                    c.minimized = true
                end ,
                {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
                function (c)
                    c.maximized = not c.maximized
                    c:raise()
                end ,
                {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
                function (c)
                    c.maximized_vertical = not c.maximized_vertical
                    c:raise()
                end ,
                {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
                function (c)
                    c.maximized_horizontal = not c.maximized_horizontal
                    c:raise()
                end ,
                {description = "(un)maximize horizontally", group = "client"})
)



event.client.buttons = gears.table.join(event.client.buttons,
        awful.button({ }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
        awful.button({ modkey }, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({ modkey }, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end),

        awful.button({ modkey }, 5, function(t)
            awful.tag.viewnext(t.screen)
        end),

        awful.button({ modkey }, 4, function(t)
            awful.tag.viewprev(t.screen)
        end)
)


event.root.keys = gears.table.join(
-- Перемещение по рабочим столам с помощью стрелок
    awful.key({ modkey }, "Left",   function(t) awful.tag.viewprev(1) end, {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right",   function(t) awful.tag.viewnext(1) end, {description = "view previous", group = "tag"}),

    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey }, "space", function () awful.layout.inc(1) end),
    --awful.key({ modkey }, "p", function() os.execute('rofi -show run') end)
    awful.key({}, "Menu", function() os.execute('~/.config/rofi/bin/launcher_colorful') end),
    awful.key({ modkey }, 'Print', function() os.execute('flameshot gui --path ~/Изображения/') end),
    awful.key({}, 'Print', function() os.execute('flameshot screen -r --path ~/Изображения/') end),
        awful.key({}, "Control_R", function() os.execute('~/.config/rofi/bin/menu_powermenu') end))

event.root.buttons = gears.table.join(
    awful.button({ modkey }, 5, awful.tag.viewnext),
    awful.button({ modkey }, 4, awful.tag.viewprev)
)

root.keys(event.root.keys)
root.buttons(event.root.buttons)

