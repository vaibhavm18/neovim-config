local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
	if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" and gpu.vendor == 0x10DE then
		config.webgpu_preferred_adapter = gpu
		break
	end
end

config.initial_cols = 120
config.initial_rows = 28
config.color_scheme = "Catppuccin Mocha (Gogh)"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.line_height = 1.15
config.font_size = 15

local gpus = wezterm.gui.enumerate_gpus()

config.webgpu_preferred_adapter = gpus[1]

config.window_background_opacity = 0.7
config.enable_tab_bar = false
config.enable_wayland = false -- set true only if you log into Wayland

config.window_padding = { left = 10, right = 10, top = 10, bottom = 2 }

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.animation_fps = 120
-- Cursor shape + blinking

return config
