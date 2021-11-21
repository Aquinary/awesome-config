local awful = require("awful")
local beautiful = require("beautiful")


awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = event.client.keys,
            buttons = event.client.buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    -- 
    {
        rule = { instance = "pamac"  },
        properties = {
            tag = ""
        }
    },

    -- 
    {
        rule = { instance = "vivaldi"  },
        properties = {
            tag = ""
        }
    },
    {
        rule = { instance = "discord"  },
        properties = {
            screen = 2,
            tag = ""
        }
    },
    {
        rule = { class = "[zZ]oho"  },
        properties = {
            tag = ""
        }
    },
    {
        rule = { instance = "telegram"  },
        properties = {
            screen = 2,
            tag = ""
        }
    },
    -- 
    {
        rule = { instance = "jetbrains-webstorm"  },
        properties = {
            tag = ""
        }
    },
    -- 
    {
        rule = { class = "[Ss]potify"},
        properties = {
            screen = 1,
            tag = ""
        }
    },
    -- 
    {
        rule = { class = "Steam"  },
        properties = {
            screen = 1,
            tag = ""
        }
    },
    {
        rule = { instance = "minecraft"  },
        properties = {
            screen = 1,
            tag = ""
        }
    },
    {
        rule = { instance = "tlauncher"  },
        properties = {
            screen = 1,
            tag = ""
        }
    },
    {
        rule = { class = "Mindustry"  },
        properties = {
            screen = 1,
            tag = ""
        }
    },
    -- 
    {
        rule = { instance = "bitwarden"  },
        properties = {
            screen = 1,
            tag = ""
        }
    },


}