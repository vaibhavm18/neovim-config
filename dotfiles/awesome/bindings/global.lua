-- ~/.config/awesome/bindings/global.lua
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")

local M = {}

local function toggle_split()
	local s = awful.screen.focused()
	local lay = awful.layout.get(s)
	if lay == awful.layout.suit.tile then
		awful.layout.set(awful.layout.suit.tile.bottom, s)
	else
		awful.layout.set(awful.layout.suit.tile, s)
	end
end

local function focus_mode_toggle()
	local c = client.focus
	if not c then
		return
	end

	local t = c.screen.selected_tag
	if not t then
		return
	end

	local clients = t:clients()
	if #clients <= 1 then
		return
	end

	local current_is_floating = c.floating or (awful.layout.get(c.screen) == awful.layout.suit.floating)

	local target = nil
	for _, cc in ipairs(clients) do
		local is_floating = cc.floating or (awful.layout.get(cc.screen) == awful.layout.suit.floating)
		if cc ~= c and is_floating ~= current_is_floating then
			target = cc
			break
		end
	end

	if not target then
		awful.client.focus.byidx(1)
		return
	end

	client.focus = target
	target:raise()
end

local resize_grabber = nil
local function stop_resize_mode()
	if resize_grabber then
		awful.keygrabber.stop(resize_grabber)
		resize_grabber = nil
	end
end

local function start_resize_mode(user)
	if resize_grabber then
		stop_resize_mode()
		return
	end

	naughty.notify({
		title = "Resize mode",
		text = "j/k/l/; or arrows. Enter/Esc/Mod+r to exit.",
		timeout = 2,
	})

	resize_grabber = awful.keygrabber.run(function(_, key, event)
		if event == "release" then
			return
		end

		if key == "Escape" or key == "Return" or key == "r" then
			stop_resize_mode()
			return
		end

		local c = client.focus
		if not c then
			return
		end

		local delta_px = user.resize.delta_px or 20
		local delta_fact = user.resize.delta_fact or 0.05

		if c.floating or (awful.layout.get(c.screen) == awful.layout.suit.floating) then
			if key == "j" or key == "Left" then
				c:relative_move(0, 0, -delta_px, 0)
			elseif key == "semicolon" or key == "Right" then
				c:relative_move(0, 0, delta_px, 0)
			elseif key == "k" or key == "Down" then
				c:relative_move(0, 0, 0, delta_px)
			elseif key == "l" or key == "Up" then
				c:relative_move(0, 0, 0, -delta_px)
			end
			return
		end

		if key == "j" or key == "Left" then
			awful.tag.incmwfact(-delta_fact)
		elseif key == "semicolon" or key == "Right" then
			awful.tag.incmwfact(delta_fact)
		elseif key == "k" or key == "Down" then
			awful.client.incwfact(delta_fact)
		elseif key == "l" or key == "Up" then
			awful.client.incwfact(-delta_fact)
		end
	end)
end

function M.build(user)
	menubar.utils.terminal = user.terminal_cmd

	local modkey = user.modkey

	local globalkeys = gears.table.join(
		awful.key({ modkey }, "Return", function()
			awful.spawn.with_shell(user.terminal_cmd)
		end, { description = "terminal", group = "launcher" }),

		awful.key({ modkey }, "d", function()
			awful.spawn.with_shell(user.apps.launcher)
		end, { description = "launcher", group = "launcher" }),

		awful.key({ modkey }, "g", function()
			awful.spawn(user.apps.chrome)
		end, { description = "chrome", group = "launcher" }),
		awful.key({ modkey }, "b", function()
			awful.spawn(user.apps.brave)
		end, { description = "brave", group = "launcher" }),
		awful.key({ modkey }, "z", function()
			awful.spawn(user.apps.zen)
		end, { description = "zen", group = "launcher" }),

		awful.key({ modkey }, "h", function()
			awful.client.focus.bydirection("left")
		end, { description = "focus left", group = "client" }),
		awful.key({ modkey }, "j", function()
			awful.client.focus.bydirection("down")
		end, { description = "focus down", group = "client" }),
		awful.key({ modkey }, "k", function()
			awful.client.focus.bydirection("up")
		end, { description = "focus up", group = "client" }),
		awful.key({ modkey }, "l", function()
			awful.client.focus.bydirection("right")
		end, { description = "focus right", group = "client" }),

		awful.key({ modkey }, "Left", function()
			awful.client.focus.bydirection("left")
		end),
		awful.key({ modkey }, "Down", function()
			awful.client.focus.bydirection("down")
		end),
		awful.key({ modkey }, "Up", function()
			awful.client.focus.bydirection("up")
		end),
		awful.key({ modkey }, "Right", function()
			awful.client.focus.bydirection("right")
		end),

		awful.key({ modkey, "Shift" }, "j", function()
			awful.client.swap.bydirection("left")
		end, { description = "move left", group = "client" }),
		awful.key({ modkey, "Shift" }, "k", function()
			awful.client.swap.bydirection("down")
		end, { description = "move down", group = "client" }),
		awful.key({ modkey, "Shift" }, "l", function()
			awful.client.swap.bydirection("up")
		end, { description = "move up", group = "client" }),
		awful.key({ modkey, "Shift" }, "semicolon", function()
			awful.client.swap.bydirection("right")
		end, { description = "move right", group = "client" }),

		awful.key({ modkey }, "q", function()
			awful.layout.set(awful.layout.suit.tile)
		end, { description = "tile", group = "layout" }),
		awful.key({ modkey }, "v", function()
			awful.layout.set(awful.layout.suit.tile.bottom)
		end, { description = "tile.bottom", group = "layout" }),
		awful.key({ modkey }, "e", toggle_split, { description = "toggle split", group = "layout" }),

		awful.key({ modkey }, "s", function()
			awful.layout.set(awful.layout.suit.tile)
		end, { description = "stacking-ish", group = "layout" }),
		awful.key({ modkey }, "w", function()
			awful.layout.set(awful.layout.suit.max)
		end, { description = "max", group = "layout" }),

		awful.key({ modkey }, "f", function()
			local c = client.focus
			if not c then
				return
			end
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "fullscreen", group = "client" }),

		awful.key({ modkey, "Shift" }, "q", function()
			local c = client.focus
			if c then
				c:kill()
			end
		end, { description = "kill", group = "client" }),

		awful.key({ modkey, "Shift" }, "space", function()
			local c = client.focus
			if not c then
				return
			end
			awful.client.floating.toggle(c)
			c:raise()
		end, { description = "toggle floating", group = "client" }),

		awful.key({ modkey }, "space", focus_mode_toggle, { description = "focus tiling/floating", group = "client" }),

		awful.key({ modkey }, "a", function()
			local s = awful.screen.focused()
			local c = awful.client.getmaster(s)
			if c then
				client.focus = c
				c:raise()
			end
		end, { description = "focus master", group = "client" }),

		awful.key({ modkey }, "r", function()
			start_resize_mode(user)
		end, { description = "resize mode", group = "layout" }),

		awful.key({ modkey, "Shift" }, "c", awesome.restart, { description = "reload", group = "awesome" }),
		awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "restart", group = "awesome" }),
		awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit", group = "awesome" }),

		awful.key({}, "Print", function()
			awful.spawn.with_shell(
				[[NOW=$(date +%d-%b-%Y_%H-%M-%S) && maim --format png --select > ~/screenshots/screenshot_$NOW.png && xclip -selection clip -t image/png ~/screenshots/screenshot_$NOW.png]]
			)
		end, { description = "screenshot", group = "utility" }),

		awful.key({ modkey, "Shift" }, "u", function()
			awful.spawn.with_shell(
				[[NOW=$(date +%d-%b-%Y_%H-%M-%S) && maim --format png --select > ~/screenshots/screenshot_$NOW.png && xclip -selection clip -t image/png ~/screenshots/screenshot_$NOW.png]]
			)
		end, { description = "screenshot", group = "utility" }),

		awful.key({}, "XF86AudioRaiseVolume", function()
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +10%")
		end, { description = "volume up", group = "media" }),

		awful.key({}, "XF86AudioLowerVolume", function()
			awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -10%")
		end, { description = "volume down", group = "media" }),

		awful.key({}, "XF86AudioMute", function()
			awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
		end, { description = "mute", group = "media" }),

		awful.key({}, "XF86AudioMicMute", function()
			awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
		end, { description = "mic mute", group = "media" })
	)

	-- Tags: Ctrl+1..9, Ctrl+0 for tag 10
	for i = 1, 9 do
		globalkeys = gears.table.join(
			globalkeys,
			awful.key({ "Control" }, "#" .. (i + 9), function()
				local s = awful.screen.focused()
				local t = s.tags[i]
				if t then
					t:view_only()
				end
			end, { description = "view tag " .. i, group = "tag" }),

			awful.key({ modkey, "Shift" }, "#" .. (i + 9), function()
				if client.focus then
					local t = client.focus.screen.tags[i]
					if t then
						client.focus:move_to_tag(t)
					end
				end
			end, { description = "move to tag " .. i, group = "tag" })
		)
	end

	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ "Control" }, "#19", function()
			local s = awful.screen.focused()
			local t = s.tags[10]
			if t then
				t:view_only()
			end
		end, { description = "view tag 10", group = "tag" }),

		awful.key({ modkey, "Shift" }, "#19", function()
			if client.focus then
				local t = client.focus.screen.tags[10]
				if t then
					client.focus:move_to_tag(t)
				end
			end
		end, { description = "move to tag 10", group = "tag" })
	)

	return globalkeys
end

return M
