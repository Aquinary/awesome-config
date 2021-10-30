local gears = require("gears")
local awful = require("awful")


modkey = 'Mod4'

  -- Переключение тегов кнопкой мыши
  taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ }, 1, function(t) t:view_only() end)
  --[[
  awful.button({ modkey }, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
          client.focus:toggle_tag(t)
      end
  end)
  --]]
  --[[
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  --]]
)

  function require_tags(screen)
    -- Добавление тегов 
    --awful.tag({"", "", "", "", "", ""}, screen, awful.layout.layouts[1])
    awful.tag({"", "", "", "", "", ""}, screen, awful.layout.layouts[1])
end




