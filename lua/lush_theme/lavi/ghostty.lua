local template = [[
background = $bg
foreground = $fg

selection-foreground = $selection_fg
selection-background = $selection_bg

cursor-color = $cursor_fg
cursor-text = $cursor_bg

split-divider-color = $med_black

palette = 0=$black
palette = 1=$red
palette = 2=$green
palette = 3=$yellow
palette = 4=$blue
palette = 5=$magenta
palette = 6=$cyan
palette = 7=$white
palette = 8=$bright_black
palette = 9=$bright_red
palette = 10=$bright_green
palette = 11=$bright_yellow
palette = 12=$bright_blue
palette = 13=$bright_magenta
palette = 14=$bright_cyan
palette = 15=$bright_white

# vim: set ft=dosini commentstring=#\ %s:
]]

local helpers = require("shipwright.transform.helpers")

local function transform(colors)
  return helpers.split_newlines(helpers.apply_template(template, colors))
end

return transform
