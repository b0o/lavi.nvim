local p = require("lush_theme.lavi.palette")

-- Colors for kitty terminal - uses raw palette colors
local colors = {
  fg = p.fg,
  bg = p.bg,
  selection_fg = p.selection_fg,
  selection_bg = p.selection_bg,
  cursor_fg = p.cursor_fg,
  cursor_bg = p.cursor_bg,

  -- Normal colors
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

-- Transform for contrib/kitty/lavi.conf
local function transform(compiled)
  local lines = {
    "# vim:ft=kitty",
    string.format("foreground                      %s", compiled.fg),
    string.format("background                      %s", compiled.bg),
    string.format("selection_foreground            %s", compiled.selection_fg),
    string.format("selection_background            %s", compiled.selection_bg),
    "# Cursor colors",
    string.format("cursor                          %s", compiled.cursor_bg),
    string.format("cursor_text_color               %s", compiled.cursor_fg),
    "# URL underline color when hovering with mouse",
    "# kitty window border colors",
    "# OS Window titlebar colors",
    "# Tab bar colors",
    "# Colors for marks (marked text in the terminal)",
    "# The basic 16 colors",
    "# black",
    string.format("color0 %s", compiled.black),
    string.format("color8 %s", compiled.bright_black),
    "# red",
    string.format("color1 %s", compiled.red),
    string.format("color9 %s", compiled.bright_red),
    "# green",
    string.format("color2  %s", compiled.green),
    string.format("color10 %s", compiled.bright_green),
    "# yellow",
    string.format("color3  %s", compiled.yellow),
    string.format("color11 %s", compiled.bright_yellow),
    "# blue",
    string.format("color4  %s", compiled.blue),
    string.format("color12 %s", compiled.bright_blue),
    "# magenta",
    string.format("color5  %s", compiled.magenta),
    string.format("color13 %s", compiled.bright_magenta),
    "# cyan",
    string.format("color6  %s", compiled.cyan),
    string.format("color14 %s", compiled.bright_cyan),
    "# white",
    string.format("color7  %s", compiled.white),
    string.format("color15 %s", compiled.bright_white),
    "# You can set the remaining 240 colors as color16 to color255.",
  }
  return lines
end

return {
  colors = colors,
  transform = transform,
}
