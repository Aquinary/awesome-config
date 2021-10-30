local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local popup = awful.popup {
    ontop = true,
    visible = true,
    maximum_width = 150,
    minimum_width = 150,
    maximum_height = 150,
    minimum_height = 150,
    hide_on_right_click = true,
    widget = {}
}

return popup


