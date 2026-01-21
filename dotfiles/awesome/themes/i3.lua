-- ~/.config/awesome/themes/i3.lua
local gears = require("gears")
local beautiful = require("beautiful")

local M = {}

function M.apply()
	beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

	beautiful.font = "JetBrainsMonoNerdFont 11"
	beautiful.useless_gap = 20
	beautiful.border_width = 1
	beautiful.wibar_height = 30

	beautiful.bg_normal = "#333C43" -- Background 0
	beautiful.bg_focus = "#3A464C" -- Background 1
	beautiful.fg_normal = "#D3C6AA" -- Foreground
	beautiful.fg_focus = "#D3C6AA" -- Foreground

	beautiful.border_focus = "#D699B6" -- Purple
	beautiful.border_normal = "#293136" -- Background Dim

	beautiful.wibar_bg = "#293136" -- Background Dim
	beautiful.wibar_fg = "#D3C6AA" -- Foreground
end

return M
