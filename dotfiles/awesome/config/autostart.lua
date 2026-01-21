-- ~/.config/awesome/config/autostart.lua
local awful = require("awful")

local M = {}

function M.run(user)
	awful.spawn.once(user.apps.autostart)
	awful.spawn.once(user.apps.lock)
	awful.spawn.once(user.apps.network)

	if user.wallpaper and #user.wallpaper > 0 then
		awful.spawn.with_shell("feh --bg-scale " .. user.wallpaper)
	end

	awful.spawn.with_shell(user.apps.compositor)
end

return M
