-- ~/.wezterm.lua
local wezterm = require("wezterm")

-- robust builder (older versions may lack config_builder)
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- ---------- OS detection ----------
local function get_os()
  local bin = package.cpath:match("%p[\\|/]?%p(%a+)")
  if bin == "dll" then return "windows"
  elseif bin == "so" then return "linux"
  else return "macos" end
end
local host_os = get_os()

-- ---------- Fonts ----------
local emoji_font = (host_os == "linux") and "Noto Color Emoji" or "Segoe UI Emoji"
config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "Regular" },
  emoji_font,
})
config.font_size = 18

-- ---------- Colors / Theme ----------
local scheme_name = "Gruvbox Dark (Gogh)"
config.color_scheme = scheme_name

-- Safely fetch the scheme table to reference colors now
local schemes = wezterm.color.get_builtin_schemes()
local scheme = schemes[scheme_name] or {}

-- ---------- Window ----------
local opacity = 0.7
config.window_background_opacity = opacity
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.force_reverse_video_cursor = true
-- Optional background image (only if it exists)
local cfg_dir = wezterm.config_dir and wezterm.config_dir or (os.getenv("HOME") .. "/.config/wezterm")
local bg_path = cfg_dir .. "/bg-blurred.png"
local f = io.open(bg_path, "r")
if f then
  f:close()
  config.window_background_image = bg_path
end

-- Linux-only front_end tweak; comment out if your build doesn’t support it
if host_os == "linux" then
  config.default_prog = { "zsh" }
  -- config.front_end = "WebGpu" -- enable if your WezTerm supports it
elseif host_os == "windows" then
  config.default_prog = { "pwsh", "-NoLogo" }
  config.win32_system_backdrop = "Acrylic"
end

-- ---------- Performance ----------
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- ---------- Tabs ----------
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Derive tab bar colors from the scheme safely (with fallbacks)
local bg      = scheme.background or "#1d2021"
local fg      = scheme.foreground or "#ebdbb2"
local brights = scheme.brights or { "#928374","#fb4934","#b8bb26","#fabd2f","#83a598","#d3869b","#8ec07c","#ebdbb2" }

config.colors = config.colors or {}
config.colors.tab_bar = {
  background = bg,
  new_tab = { fg_color = bg, bg_color = brights[6] or "#d3869b" },
  new_tab_hover = { fg_color = bg, bg_color = fg },
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
  local active_bg = brights[7] or "#8ec07c"
  local hover_bg  = brights[8] or "#ebdbb2"
  local normal_bg = brights[1] or "#928374"

  local back = normal_bg
  local fore = fg
  if tab.is_active then
    back = active_bg
    fore = bg
  elseif hover then
    back = hover_bg
    fore = bg
  end

  local title = tostring(tab.tab_index + 1)
  return {
    { Foreground = { Color = back } }, { Text = "█" },
    { Background = { Color = back } }, { Foreground = { Color = fore } }, { Text = title },
    { Foreground = { Color = back } }, { Text = "█" },
  }
end)

-- ---------- Keys ----------
config.keys = {
  { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration }, -- ensure reload works
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
}

return config
