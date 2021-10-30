local awful = require("awful")
local wibox = require("wibox")
local os = require('os')
local gears = require("gears")

local function change_layout()
    -- Changes the keyboard layout and displays the change in the icon in the taskbar
    local layout = os.capture('xkblayout-state print %s')
    widget.widget.image = GET_FILE_PATH() .. layout .. '.png'
end

widget =  wibox.widget
{
    {
        image         = '',
        forced_height = 19,
        forced_width  = 19,
        halign        = 'center',
        resize        = true,
        widget        = wibox.widget.imagebox
    },
    left = 0,
    right = 0,
    top = 5,
    bottom = 5,
    widget = wibox.container.margin
}


change_layout()

-- Fixing the combination to the right alt
event.root.keys = gears.table.join(event.root.keys,
        awful.key({}, "#108", function() change_layout();  end)
)

root.keys(event.root.keys)
return widget