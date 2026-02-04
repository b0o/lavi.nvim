local p = require("lush_theme.lavi.palette")

-- btop theme with muted colors matching the nvim theme aesthetic
local M = {
  -- Main background, empty for terminal default
  main_bg = p.bg,

  -- Main text color
  main_fg = p.fg_nc,

  -- Title color for boxes
  title = p.fg_dim,

  -- Highlight color for keyboard shortcuts
  hi_fg = p.yellow.lighten(20).desaturate(20),

  -- Background color of selected items
  selected_bg = p.deep_anise,

  -- Foreground color of selected items
  selected_fg = p.bright_white,

  -- Color of inactive/disabled text
  inactive_fg = p.bright_black.darken(20),

  -- Color of text appearing on top of graphs
  graph_text = p.bright_black.darken(10),

  -- Background color of the percentage meters
  meter_bg = p.med_black,

  -- Misc colors for processes box
  proc_misc = p.matcha,

  -- Box outline colors (matching zellij frame_unselected)
  cpu_box = p.bright_black.darken(10),
  mem_box = p.bright_black.darken(10),
  net_box = p.bright_black.darken(10),
  proc_box = p.bright_black.darken(10),

  -- Box divider line
  div_line = p.med_black,

  -- Temperature graph colors (cool to hot)
  temp_start = p.oceanblue.desaturate(20),
  temp_mid = p.velvet,
  temp_end = p.cayenne.lighten(10).desaturate(10),

  -- CPU graph colors (low to high: green -> blue -> purple)
  cpu_start = p.matcha,
  cpu_mid = p.oceanblue.desaturate(10),
  cpu_end = p.lavender,

  -- Mem/Disk free meter (green)
  free_start = p.matcha.darken(30),
  free_mid = "",
  free_end = p.matcha,

  -- Mem/Disk cached meter (blue)
  cached_start = p.oceanblue.darken(20).desaturate(10),
  cached_mid = "",
  cached_end = p.oceanblue.desaturate(10),

  -- Mem/Disk available meter (purple)
  available_start = p.velvet.darken(20),
  available_mid = "",
  available_end = p.velvet,

  -- Mem/Disk used meter (purple -> yellow hint)
  used_start = p.lavender.darken(20),
  used_mid = "",
  used_end = p.yellow.lighten(20).desaturate(20),

  -- Download graph colors (blue -> cyan)
  download_start = p.anise.lighten(10).desaturate(20),
  download_mid = p.oceanblue.desaturate(10),
  download_end = p.cyan.desaturate(20).lighten(20),

  -- Upload graph colors (purple -> pink)
  upload_start = p.velvet.darken(10),
  upload_mid = p.lavender,
  upload_end = p.blush,

  -- Process box color gradient (green -> blue -> purple)
  process_start = p.matcha,
  process_mid = p.oceanblue.desaturate(10),
  process_end = p.lavender,
}

return M
