-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.

pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")


require('settings.utils')

require('settings.keys')
require('settings.tasks')
require('settings.tags')
require('settings.panel')


require('settings.widgets')
require('widgets.app_menu.volume')

os.setlocale(os.getenv("LANG"))
-- Общие темы для WM
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 5
beautiful.gap_single_client = true
beautiful.font = "Iosevka Bold 10"
beautiful.taglist_font = "icons-in-terminal 13"
beautiful.border_focus = "#A2D2FF"

-- Терминал и редактор по умолчаниюdsdsdsвыв
terminal = "sakura"
editor = os.getenv("EDITOR") or "subl"
editor_cmd = terminal .. " -e " .. editor


-- Какие режимы для рабочего стола доступны
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
}

awful.screen.connect_for_each_screen(function(s)
    gears.wallpaper.maximized(GET_FILE_PATH() .. 'settings/wall.png', s, true)

    require_tags(s)
    require_widgets(s)
    require_panel(s)
end)

-- Сигналы для событий
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("mouse::move", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    change_title_bar(c)
    --widgets.titlebar.widget.text = tostring(c.name)
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal

    --widgets.titlebar.widget.text = ''
end)

require('settings.rules')