-- ~/.config/awesome/config/layouts.lua
local awful = require("awful")

local M = {}

function M.apply()
	awful.layout.layouts = {
		awful.layout.suit.tile,
		awful.layout.suit.max,
		awful.layout.suit.floating,
	}
end

return M
