local helpers = require("shipwright.transform.helpers")

local template = [[
[colors.primary]
background = "$bg"
foreground = "$fg"
dim_foreground = "$fg_dim"
bright_foreground = "$fg_bright"

[colors.cursor]
text = "$cursor_fg"
cursor = "$cursor_bg"

[colors.vi_mode_cursor]
text = "$cursor_fg"
cursor = "$cursor_bg"

[colors.search.matches]
foreground = "$blush"
background = "$bg"

[colors.search.focused_match]
foreground = "$bg"
background = "$blush"

[colors.footer_bar]
foreground = "$fg"
background = "$bg_bright"

[colors.hints.start]
foreground = "$med_violet"
background = "$bg_bright"

[colors.hints.end]
foreground = "$fg"
background = "$bg_bright"

[colors.selection]
text = "$selection_fg"
background = "$selection_bg"

[colors.normal]
black = "$black"
red = "$red"
green = "$green"
yellow = "$yellow"
blue = "$blue"
magenta = "$magenta"
cyan = "$cyan"
white = "$white"

[colors.bright]
black = "$bright_black"
red = "$bright_red"
green = "$bright_green"
yellow = "$bright_yellow"
blue = "$bright_blue"
magenta = "$bright_magenta"
cyan = "$bright_cyan"
white = "$bright_white"
]]

local function transform(colors)
  return helpers.split_newlines(helpers.apply_template(template, colors))
end

return transform
