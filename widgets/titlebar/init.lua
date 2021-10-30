local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local os = require('os')
local gears = require("gears")

function change_title_bar(c)
    if c.screen.index == 1 then
        left.widget.text = tostring(c.class) .. ' - ' .. tostring(c.name)
        right.widget.text = ''
    end
    if c.screen.index == 2 then
        right.widget.text = tostring(c.class) .. ' - ' .. tostring(c.name)
        left.widget.text = ''
    end
end

left = wibox.widget
{
    {
        text = 'test',
        align='center',
        widget = wibox.widget.textbox
    },
    widget = wibox.container.place
}

right = wibox.widget
{
    {
        text = 'test',
        align='center',
        widget = wibox.widget.textbox
    },
    widget = wibox.container.place
}

widget = {left = left, right = right}
return widget
