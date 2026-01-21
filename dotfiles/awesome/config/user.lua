-- ~/.config/awesome/config/user.lua
local M = {}

M.modkey = "Mod4"

-- Switch theme by changing this one string:
M.theme_name = "i3" -- file: ~/.config/awesome/themes/i3.lua

M.terminal_cmd = "env __NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia "
	.. "/home/vaibhav18/AppImages/wezterm"

M.apps = {
	launcher = "rofi -show run",
	chrome = "google-chrome",
	brave = "brave-browser",
	zen = "zen",
	lock = "xss-lock --transfer-sleep-lock -- i3lock --nofork",
	network = "nm-applet",
	autostart = "dex --autostart --environment i3",
	compositor = "picom --config ~/.config/picom/picom.conf",
}

M.wallpaper = "/home/vaibhav18/wallpaper/bg-24.jpg"

M.bar = {
	position = "top",
	show_systray = true,
	clock_format = " %a %d %b  %H:%M ",
	tag_names = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" },
}

M.resize = {
	delta_px = 20,
	delta_fact = 0.05,
}

return M
