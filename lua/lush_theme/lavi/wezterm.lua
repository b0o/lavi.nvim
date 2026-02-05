local p = require("lush_theme.lavi.palette")

-- Colors for wezterm terminal - uses raw palette colors
local colors = {
  fg = p.fg,
  bg = p.bg,
  cursor_fg = p.cursor_fg,
  cursor_bg = p.cursor_bg,
  cursor_border = p.cursor_border,
  selection_fg = p.selection_fg,
  selection_bg = p.selection_bg,

  -- Normal colors (ansi)
  black = p.black,
  red = p.red,
  green = p.green,
  yellow = p.yellow,
  blue = p.blue,
  magenta = p.magenta,
  cyan = p.cyan,
  white = p.white,

  -- Bright colors
  bright_black = p.bright_black,
  bright_red = p.bright_red,
  bright_green = p.bright_green,
  bright_yellow = p.bright_yellow,
  bright_blue = p.bright_blue,
  bright_magenta = p.bright_magenta,
  bright_cyan = p.bright_cyan,
  bright_white = p.bright_white,
}

-- Transform for contrib/wezterm/lavi.toml
local function transform(compiled)
  local lines = {
    "[colors]",
    string.format('foreground    = "%s"', compiled.fg),
    string.format('background    = "%s"', compiled.bg),
    string.format('cursor_fg     = "%s"', compiled.cursor_fg),
    string.format('cursor_bg     = "%s"', compiled.cursor_bg),
    string.format('cursor_border = "%s"', compiled.cursor_border),
    string.format('selection_fg  = "%s"', compiled.selection_fg),
    string.format('selection_bg  = "%s"', compiled.selection_bg),
    string.format(
      'ansi = ["%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s"]',
      compiled.black,
      compiled.red,
      compiled.green,
      compiled.yellow,
      compiled.blue,
      compiled.magenta,
      compiled.cyan,
      compiled.white
    ),
    string.format(
      'brights = ["%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s"]',
      compiled.bright_black,
      compiled.bright_red,
      compiled.bright_green,
      compiled.bright_yellow,
      compiled.bright_blue,
      compiled.bright_magenta,
      compiled.bright_cyan,
      compiled.bright_white
    ),
  }
  return lines
end

return {
  colors = colors,
  transform = transform,
}
