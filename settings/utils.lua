local awful = require("awful")
local awful_old = require('awful')
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local naughty = require("naughty")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Вывод ошибок после запускау
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

function pprint (text)
    naughty.notify({preset = naughty.config.presets.critical, title = tostring(text)})
end

GET_FILE_PATH = function() return debug.getinfo(2).source:match("@?(.*/)") end

popups = popups or {}

function popup_unfocused(popup)
    -- Граббер не активируется, если попап неактивен
    popup:connect_signal("property::visible", function()
        local _key_grabber
        if popup.visible then
            _key_grabber = awful.keygrabber.run(function(mod, key, event)
                popup.visible = false
                awful.keygrabber.stop(_key_grabber)
            end)
        end
    end)

    -- Клик на рабочий стол
    root.buttons(gears.table.join(root.buttons(),
        awful.button({}, 1, function() popup.visible = false end),
        awful.button({}, 2, function() popup.visible = false end),
        awful.button({}, 3, function() popup.visible = false end)
    ))
    -- Клик в область клиента
    event.client.buttons = gears.table.join(event.client.buttons,
        awful.button({}, 1, function() popup.visible = false end),
        awful.button({}, 2, function() popup.visible = false end),
        awful.button({}, 3, function() popup.visible = false end)
    )
end


function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end