-- ~/.config/awesome/client/rules.lua
local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.build()
	return {
		{
			rule = {},
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
				titlebars_enabled = false,
			},
		},
		{
			rule_any = {
				class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "pinentry" },
				name = { "Event Tester" },
				role = { "pop-up" },
			},
			properties = { floating = true },
		},
	}
end

return M
