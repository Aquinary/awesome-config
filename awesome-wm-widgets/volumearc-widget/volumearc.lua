-------------------------------------------------
-- Volume Arc Widget for Awesome Window Manager
-- Shows the current volume level
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volumearc-widget

-- @author Pavel Makhov
-- @copyright 2018 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local GET_VOLUME_CMD = 'amixer sget Master'
local INC_VOLUME_CMD = 'amixer sset Master 1%+'
local DEC_VOLUME_CMD = 'amixer sset Master 1%-'
local TOG_VOLUME_CMD = 'pactl set-sink-mute 0 toggle'

local PATH_TO_ICON = "/usr/share/icons/Arc/status/symbolic/audio-volume-muted-symbolic.svg"

local icon = {
    id = "icon",
    image = PATH_TO_ICON,
    resize = true,
    widget = wibox.widget.imagebox,
}

local volumearc = wibox.widget {
    icon,
    max_value = 1,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 16,
    forced_width = 16,
    bg = "#FFFFFF50",
    paddings = 2,
    widget = wibox.container.arcchart
}
local naughty = require("naughty")
local update_graphic = function(widget, stdout, _, _, _)
    local mute = string.match(stdout, "%[(o%D%D?)%]")
    local volume = string.match(stdout, "(%d?%d?%d)%%")
    volume = tonumber(string.format("% 3d", volume))

    widget.colors = mute == 'off' and { "#FF0000" }
    widget.value = volume / 100;
end

volumearc:connect_signal("button::press", function(_, _, _, button)
    if (button == 4) then awful.spawn(INC_VOLUME_CMD, false)
    elseif (button == 5) then awful.spawn(DEC_VOLUME_CMD, false)
    elseif (button == 1) then awful.spawn(TOG_VOLUME_CMD, false)
    end

    spawn.easy_async(GET_VOLUME_CMD, function(stdout, stderr, exitreason, exitcode)
        update_graphic(volumearc, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(GET_VOLUME_CMD, 1, update_graphic, volumearc)

volumearc = wibox.container.margin(volumearc, 0, 0, 0, 4)
return volumearc