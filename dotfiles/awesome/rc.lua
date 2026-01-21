-- ~/.config/awesome/rc.lua
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")

-- ---------------------------------------------------------
-- Error handling
-- ---------------------------------------------------------
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Awesome startup errors",
		text = awesome.startup_errors,
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end
		in_error = true
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Awesome runtime error",
			text = tostring(err),
		})
		in_error = false
	end)
end

-- ---------------------------------------------------------
-- Load config + theme
-- ---------------------------------------------------------
local user = require("config.user")
require("themes." .. user.theme_name).apply()

-- ---------------------------------------------------------
-- Layouts, autostart, UI, bindings, rules, signals
-- ---------------------------------------------------------
require("config.layouts").apply()
require("config.autostart").run(user)
require("ui.bar").setup(user)

root.keys(require("bindings.global").build(user))

root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))

awful.rules.rules = require("client.rules").build()
require("client.signals").setup()
