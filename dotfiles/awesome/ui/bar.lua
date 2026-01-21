-- ~/.config/awesome/ui/bar.lua
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local M = {}

-- Small helpers -------------------------------------------------------------

local function spacer(px)
	return wibox.widget({
		forced_width = px or 8,
		layout = wibox.layout.fixed.horizontal,
	})
end

local function pill(widget, bg)
	-- "Pill" container: dim background + rounded shape
	return wibox.widget({
		{
			{
				widget,
				left = 10,
				right = 10,
				top = 4,
				bottom = 4,
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
			bg = bg or beautiful.bg_focus or beautiful.bg_normal,
			shape = function(cr, w, h)
				gears.shape.rounded_bar(cr, w, h)
			end,
		},
		widget = wibox.container.margin,
		left = 4,
		right = 4,
	})
end

local function textbox(markup)
	return wibox.widget({
		markup = markup,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})
end

-- Window count widget (per screen) ------------------------------------------

local function make_window_count_widget(s)
	local w = textbox("󰣆 0") -- Nerd Font icon; change if you want

	local function update()
		local count = 0
		for _, c in ipairs(client.get(s)) do
			-- count clients that belong to any selected tag on this screen
			for _, t in ipairs(c:tags()) do
				if t.screen == s and t.selected then
					count = count + 1
					break
				end
			end
		end
		w.markup = string.format("󰣆 %d", count)
	end

	-- Update on common events
	client.connect_signal("manage", function(c)
		if c.screen == s then
			update()
		end
	end)
	client.connect_signal("unmanage", function(c)
		if c.screen == s then
			update()
		end
	end)
	tag.connect_signal("property::selected", function(t)
		if t.screen == s then
			update()
		end
	end)
	client.connect_signal("property::tags", function(c)
		if c.screen == s then
			update()
		end
	end)

	-- initial
	gears.timer.delayed_call(update)

	return pill(w, beautiful.bg_focus)
end

-- Watch widgets (shell) ------------------------------------------------------

local function watch_pill(cmd, timeout, icon, bg)
	-- Uses awful.widget.watch to refresh command output
	local w = awful.widget.watch(cmd, timeout, function(widget, stdout)
		stdout = (stdout or ""):gsub("\n", ""):gsub("^%s+", ""):gsub("%s+$", "")
		if icon and icon ~= "" then
			widget.markup = icon .. " " .. stdout
		else
			widget.markup = stdout
		end
	end, textbox("…"))
	return pill(w, bg)
end

-- Memory: used% based on MemAvailable ---------------------------------------
local function make_mem_widget()
	-- Outputs: "42%"
	local cmd = [[bash -lc '
awk "
/MemTotal:/ {t=\$2}
/MemAvailable:/ {a=\$2}
END{
 if(t>0){
  u=t-a; p=(u*100)/t;
  printf(\"%d%%\", p)
 } else {
  printf(\"?\")
 }
}" /proc/meminfo
']]
	return watch_pill(cmd, 5, "󰍛", beautiful.bg_focus) -- icon: memory
end

-- Network: iface + ip + ssid + down/up speed --------------------------------
local function make_net_widget()
	-- Outputs something like:
	-- "wlan0 192.168.1.10 MyWiFi ⇣120K/s ⇡18K/s"
	--
	-- Notes:
	-- - SSID needs iwgetid (wireless-tools). If missing, it just won’t show SSID.
	-- - Speed uses /tmp state file for deltas.
	local cmd = [[bash -lc '
set -e
iface=$(ip route show default 2>/dev/null | awk "{for(i=1;i<=NF;i++) if(\$i==\"dev\"){print \$(i+1); exit}}")
if [ -z "$iface" ]; then
  echo "offline"
  exit 0
fi

rx=$(cat /sys/class/net/"$iface"/statistics/rx_bytes 2>/dev/null || echo 0)
tx=$(cat /sys/class/net/"$iface"/statistics/tx_bytes 2>/dev/null || echo 0)
now=$(date +%s)

state="/tmp/awesome-net-$iface"
drx=0; dtx=0
if [ -f "$state" ]; then
  read -r lrx ltx lts < "$state" || true
  dt=$((now - lts)); [ "$dt" -le 0 ] && dt=1
  drx=$(((rx - lrx) / dt)); [ "$drx" -lt 0 ] && drx=0
  dtx=$(((tx - ltx) / dt)); [ "$dtx" -lt 0 ] && dtx=0
fi
echo "$rx $tx $now" > "$state"

fmt() {
  b=$1
  if [ "$b" -ge 1048576 ]; then awk -v b="$b" "BEGIN{printf(\"%.1fM\", b/1048576)}"
  elif [ "$b" -ge 1024 ]; then awk -v b="$b" "BEGIN{printf(\"%.0fK\", b/1024)}"
  else printf("%dB" "$b"
  fi
}

ip4=$(ip -4 addr show dev "$iface" 2>/dev/null | awk "/inet /{print \$2; exit}" | cut -d/ -f1)
[ -z "$ip4" ] && ip4="no-ip"

ssid=$(iwgetid -r 2>/dev/null || true)

if [ -n "$ssid" ]; then
  echo "$iface $ip4 $ssid ⇣$(fmt $drx)/s ⇡$(fmt $dtx)/s"
else
  echo "$iface $ip4 ⇣$(fmt $drx)/s ⇡$(fmt $dtx)/s"
fi
']]
	return watch_pill(cmd, 2, "󰖩", beautiful.bg_focus) -- icon: network
end

-- Clock ---------------------------------------------------------------------
local function make_clock(user)
	-- Your format comes from user.bar.clock_format
	-- (Awesome supports GLib DateTime format)
	local clock = wibox.widget.textclock(user.bar.clock_format, 1)
	return pill(clock, beautiful.bg_focus)
end

-- Setup ---------------------------------------------------------------------

function M.setup(user)
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({}, 3, awful.tag.viewtoggle)
	)

	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 320 } })
		end)
	)

	awful.screen.connect_for_each_screen(function(s)
		awful.tag(user.bar.tag_names, s, awful.layout.layouts[1])

		-- Taglist (with better spacing)
		s.mytaglist = awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			buttons = taglist_buttons,
			layout = {
				spacing = 6,
				layout = wibox.layout.fixed.horizontal,
			},
		})

		-- Tasklist (current tags)
		s.mytasklist = awful.widget.tasklist({
			screen = s,
			filter = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons,
			layout = {
				spacing = 8,
				layout = wibox.layout.fixed.horizontal,
			},
		})

		-- Optional layoutbox (nice to have)
		s.mylayoutbox = awful.widget.layoutbox(s)
		s.mylayoutbox:buttons(gears.table.join(
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(-1)
			end)
		))

		s.mywibox = awful.wibar({
			position = user.bar.position or "top",
			screen = s,
			height = beautiful.wibar_height or 30,
			bg = beautiful.wibar_bg,
			fg = beautiful.wibar_fg,
		})

		-- Left: tags + window count
		local left_widgets = {
			layout = wibox.layout.fixed.horizontal,
			spacer(6),
			s.mytaglist,
			spacer(10),
			make_window_count_widget(s),
		}

		-- Right: systray + net + mem + clock + layout
		local right_widgets = {
			layout = wibox.layout.fixed.horizontal,
		}

		if user.bar.show_systray then
			local tray = wibox.widget.systray()
			table.insert(right_widgets, spacer(8))
			table.insert(right_widgets, tray)
			table.insert(right_widgets, spacer(10))
		end

		table.insert(right_widgets, make_net_widget())
		table.insert(right_widgets, make_mem_widget())
		table.insert(right_widgets, make_clock(user))
		table.insert(right_widgets, pill(s.mylayoutbox, beautiful.bg_focus))
		table.insert(right_widgets, spacer(6))

		s.mywibox:setup({
			layout = wibox.layout.align.horizontal,
			left_widgets,
			-- Center: tasklist (give it breathing room)
			{
				{
					s.mytasklist,
					left = 8,
					right = 8,
					widget = wibox.container.margin,
				},
				widget = wibox.container.background,
				bg = beautiful.wibar_bg,
			},
			right_widgets,
		})
	end)
end

return M
