vim.env.LAZY_STDPATH = "build/.nvim"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local function project_root()
  return vim.fn.fnamemodify(debug.getinfo(2, "S").source:sub(2):match("(.*/)"), ":p:h")
end

require("lazy.minit").setup({
  spec = {
    "rktjmp/lush.nvim",
    "rktjmp/shipwright.nvim",
  },
})

vim.opt.rtp:prepend(project_root())

local function is_lush_color(v)
  return type(v) == "table" and type(v.hsl) == "table"
end

local function compile_palette(palette)
  return vim.iter(pairs(palette)):fold({}, function(acc, k, v)
    if type(v) == "table" then
      if is_lush_color(v) then
        acc[k] = tostring(v)
      else
        acc[k] = compile_palette(v)
      end
    else
      acc[k] = v
    end
    return acc
  end)
end

local function transform_lua(theme)
  local lines = vim.split(vim.inspect(vim.json.decode(vim.json.encode(theme, { sort_keys = true })), {}), "\n")
  lines[1] = "return {"
  return lines
end

local function transform_json(theme)
  return vim.split(vim.json.encode(theme, { sort_keys = true }), "\n")
end

local function transform_kdl(theme, top_level)
  top_level = top_level == nil or top_level
  local indent = top_level and "" or "  "
  local theme_items = vim.iter(vim.deepcopy(theme)):totable()

  table.sort(theme_items, function(a, b)
    local a_key, a_val = a[1], a[2]
    local b_key, b_val = b[1], b[2]
    if is_lush_color(a_val) and not is_lush_color(b_val) then
      return true
    elseif not is_lush_color(a_val) and is_lush_color(b_val) then
      return false
    end
    return a_key < b_key
  end)

  return vim.iter(theme_items):fold({}, function(acc, e)
    local k, v = unpack(e)
    local lines = {}
    if type(v) == "table" and (type(v.hex) ~= "string") then
      table.insert(lines, k .. " {")
      vim.list_extend(lines, transform_kdl(v, false))
      table.insert(lines, "}")
    else
      table.insert(lines, k .. ' "' .. tostring(v) .. '"')
    end
    vim.list_extend(
      acc,
      vim
        .iter(lines)
        :map(function(line)
          return indent .. line
        end)
        :totable()
    )
    return acc
  end)
end

local function transform_toml(theme, prefix)
  prefix = prefix or ""
  local lines = {}

  -- Separate tables from simple values
  local simple_values = {}
  local tables = {}
  local arrays = {}

  for k, v in pairs(theme) do
    if type(v) == "table" then
      if v[1] ~= nil then
        -- It's an array
        arrays[k] = v
      elseif is_lush_color(v) then
        simple_values[k] = tostring(v)
      elseif v.color or v.bg_color or v.bold ~= nil then
        -- Inline table for text styling
        simple_values[k] = v
      else
        tables[k] = v
      end
    else
      simple_values[k] = v
    end
  end

  -- Write simple values first
  local sorted_keys = vim.tbl_keys(simple_values)
  table.sort(sorted_keys)
  for _, k in ipairs(sorted_keys) do
    local v = simple_values[k]
    if type(v) == "table" then
      -- Inline table (text styling)
      local parts = {}
      if v.color then
        table.insert(parts, string.format('color = "%s"', tostring(v.color)))
      end
      if v.bg_color then
        table.insert(parts, string.format('bg_color = "%s"', tostring(v.bg_color)))
      end
      if v.bold ~= nil then
        table.insert(parts, string.format("bold = %s", tostring(v.bold)))
      end
      table.insert(lines, string.format("%s = { %s }", k, table.concat(parts, ", ")))
    else
      table.insert(lines, string.format('%s = "%s"', k, v))
    end
  end

  -- Write arrays
  local sorted_array_keys = vim.tbl_keys(arrays)
  table.sort(sorted_array_keys)
  for _, k in ipairs(sorted_array_keys) do
    local arr = arrays[k]
    local items = {}
    for _, item in ipairs(arr) do
      table.insert(items, string.format('"%s"', tostring(item)))
    end
    table.insert(lines, string.format("%s = [\n  %s,\n]", k, table.concat(items, ",\n  ")))
  end

  -- Write nested tables
  local sorted_table_keys = vim.tbl_keys(tables)
  table.sort(sorted_table_keys)
  for _, k in ipairs(sorted_table_keys) do
    local section = prefix ~= "" and (prefix .. "." .. k) or k
    table.insert(lines, "")
    table.insert(lines, string.format("[%s]", section))
    vim.list_extend(lines, transform_toml(tables[k], section))
  end

  return lines
end

local function transform_btop(theme)
  local lines = {
    "# Lavi theme for btop",
    "# https://github.com/b0o/lavi.nvim",
    "",
  }

  -- Define the order of keys to match btop's convention
  local key_order = {
    "main_bg",
    "main_fg",
    "title",
    "hi_fg",
    "selected_bg",
    "selected_fg",
    "inactive_fg",
    "graph_text",
    "meter_bg",
    "proc_misc",
    "cpu_box",
    "mem_box",
    "net_box",
    "proc_box",
    "div_line",
    "temp_start",
    "temp_mid",
    "temp_end",
    "cpu_start",
    "cpu_mid",
    "cpu_end",
    "free_start",
    "free_mid",
    "free_end",
    "cached_start",
    "cached_mid",
    "cached_end",
    "available_start",
    "available_mid",
    "available_end",
    "used_start",
    "used_mid",
    "used_end",
    "download_start",
    "download_mid",
    "download_end",
    "upload_start",
    "upload_mid",
    "upload_end",
    "process_start",
    "process_mid",
    "process_end",
  }

  for _, k in ipairs(key_order) do
    local v = theme[k]
    if v ~= nil then
      local value = type(v) == "string" and v or tostring(v)
      table.insert(lines, string.format('theme[%s]="%s"', k, value))
    end
  end

  return lines
end

local function transform_nix_ghostty(palette)
  local lines = {
    "# Auto-generated by build.lua - do not edit manually",
    "{",
  }

  -- Add single-value keys (hex values without # prefix)
  local single_keys = {
    { key = "background", value = palette.bg },
    { key = "foreground", value = palette.fg },
    { key = "cursor-color", value = palette.cursor_bg },
    { key = "cursor-text", value = palette.cursor_fg },
    { key = "selection-background", value = palette.selection_bg },
    { key = "selection-foreground", value = palette.selection_fg },
  }

  for _, item in ipairs(single_keys) do
    table.insert(lines, string.format('  %s = "%s";', item.key, tostring(item.value):sub(2)))
  end

  -- Add palette array
  table.insert(lines, "  palette = [")
  local palette_colors = {
    palette.black,
    palette.red,
    palette.green,
    palette.yellow,
    palette.blue,
    palette.magenta,
    palette.cyan,
    palette.white,
    palette.bright_black,
    palette.bright_red,
    palette.bright_green,
    palette.bright_yellow,
    palette.bright_blue,
    palette.bright_magenta,
    palette.bright_cyan,
    palette.bright_white,
  }
  for i, color in ipairs(palette_colors) do
    table.insert(lines, string.format('    "%d=%s"', i - 1, tostring(color)))
  end
  table.insert(lines, "  ];")
  table.insert(lines, "}")

  return lines
end

local function transform_nix_alacritty(palette)
  local lines = {
    "# Auto-generated by build.lua - do not edit manually",
    "# For use with home-manager's programs.alacritty.settings",
    "{",
    "  colors = {",
    "    primary = {",
    string.format('      background = "%s";', tostring(palette.bg)),
    string.format('      foreground = "%s";', tostring(palette.fg)),
    string.format('      dim_foreground = "%s";', tostring(palette.fg_dim)),
    string.format('      bright_foreground = "%s";', tostring(palette.fg_bright)),
    "    };",
    "    cursor = {",
    string.format('      text = "%s";', tostring(palette.cursor_fg)),
    string.format('      cursor = "%s";', tostring(palette.cursor_bg)),
    "    };",
    "    vi_mode_cursor = {",
    string.format('      text = "%s";', tostring(palette.cursor_fg)),
    string.format('      cursor = "%s";', tostring(palette.cursor_bg)),
    "    };",
    "    search = {",
    "      matches = {",
    string.format('        foreground = "%s";', tostring(palette.blush)),
    string.format('        background = "%s";', tostring(palette.bg)),
    "      };",
    "      focused_match = {",
    string.format('        foreground = "%s";', tostring(palette.bg)),
    string.format('        background = "%s";', tostring(palette.blush)),
    "      };",
    "    };",
    "    footer_bar = {",
    string.format('      foreground = "%s";', tostring(palette.fg)),
    string.format('      background = "%s";', tostring(palette.bg_bright)),
    "    };",
    "    hints = {",
    "      start = {",
    string.format('        foreground = "%s";', tostring(palette.med_violet)),
    string.format('        background = "%s";', tostring(palette.bg_bright)),
    "      };",
    "      \"end\" = {",
    string.format('        foreground = "%s";', tostring(palette.fg)),
    string.format('        background = "%s";', tostring(palette.bg_bright)),
    "      };",
    "    };",
    "    selection = {",
    string.format('      text = "%s";', tostring(palette.selection_fg)),
    string.format('      background = "%s";', tostring(palette.selection_bg)),
    "    };",
    "    normal = {",
    string.format('      black = "%s";', tostring(palette.black)),
    string.format('      red = "%s";', tostring(palette.red)),
    string.format('      green = "%s";', tostring(palette.green)),
    string.format('      yellow = "%s";', tostring(palette.yellow)),
    string.format('      blue = "%s";', tostring(palette.blue)),
    string.format('      magenta = "%s";', tostring(palette.magenta)),
    string.format('      cyan = "%s";', tostring(palette.cyan)),
    string.format('      white = "%s";', tostring(palette.white)),
    "    };",
    "    bright = {",
    string.format('      black = "%s";', tostring(palette.bright_black)),
    string.format('      red = "%s";', tostring(palette.bright_red)),
    string.format('      green = "%s";', tostring(palette.bright_green)),
    string.format('      yellow = "%s";', tostring(palette.bright_yellow)),
    string.format('      blue = "%s";', tostring(palette.bright_blue)),
    string.format('      magenta = "%s";', tostring(palette.bright_magenta)),
    string.format('      cyan = "%s";', tostring(palette.bright_cyan)),
    string.format('      white = "%s";', tostring(palette.bright_white)),
    "    };",
    "  };",
    "}",
  }
  return lines
end

local function transform_nix_foot(palette)
  local lines = {
    "# Auto-generated by build.lua - do not edit manually",
    "# For use with home-manager's programs.foot.settings",
    "{",
    "  cursor = {",
    string.format('    color = "%s %s";', tostring(palette.cursor_fg):sub(2), tostring(palette.cursor_bg):sub(2)),
    "  };",
    "  colors = {",
    string.format('    background = "%s";', tostring(palette.bg):sub(2)),
    string.format('    foreground = "%s";', tostring(palette.fg):sub(2)),
    string.format('    regular0 = "%s";', tostring(palette.black):sub(2)),
    string.format('    regular1 = "%s";', tostring(palette.red):sub(2)),
    string.format('    regular2 = "%s";', tostring(palette.green):sub(2)),
    string.format('    regular3 = "%s";', tostring(palette.yellow):sub(2)),
    string.format('    regular4 = "%s";', tostring(palette.blue):sub(2)),
    string.format('    regular5 = "%s";', tostring(palette.magenta):sub(2)),
    string.format('    regular6 = "%s";', tostring(palette.cyan):sub(2)),
    string.format('    regular7 = "%s";', tostring(palette.white):sub(2)),
    string.format('    bright0 = "%s";', tostring(palette.bright_black):sub(2)),
    string.format('    bright1 = "%s";', tostring(palette.bright_red):sub(2)),
    string.format('    bright2 = "%s";', tostring(palette.bright_green):sub(2)),
    string.format('    bright3 = "%s";', tostring(palette.bright_yellow):sub(2)),
    string.format('    bright4 = "%s";', tostring(palette.bright_blue):sub(2)),
    string.format('    bright5 = "%s";', tostring(palette.bright_magenta):sub(2)),
    string.format('    bright6 = "%s";', tostring(palette.bright_cyan):sub(2)),
    string.format('    bright7 = "%s";', tostring(palette.bright_white):sub(2)),
    "  };",
    "}",
  }
  return lines
end

vim.api.nvim_create_user_command("LaviBuild", function()
  local builder = require("shipwright.builder")
  local palette = require("lush_theme.lavi.palette")

  -- TODO: vivid
  -- TODO: bat

  builder.run(
    require("lush_theme.lavi"),
    require("shipwright.transform.lush").to_lua,
    { require("shipwright.transform.patchwrite"), "colors/lavi.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE" }
  )

  builder.run(
    palette,
    compile_palette,
    transform_lua,
    { require("shipwright.transform.overwrite"), "lua/lavi/palette.lua" }
  )

  builder.run(
    require("lush_theme.lavi.lualine"),
    transform_lua,
    { require("shipwright.transform.overwrite"), "lua/lualine/themes/lavi.lua" }
  )

  builder.run(
    palette,
    require("lush_theme.lavi.alacritty"),
    { require("shipwright.transform.overwrite"), "contrib/alacritty/lavi.toml" }
  )

  builder.run(
    palette,
    require("shipwright.transform.contrib.foot"),
    { require("shipwright.transform.overwrite"), "contrib/foot/lavi.ini" }
  )

  builder.run(
    palette,
    require("lush_theme.lavi.ghostty"),
    { require("shipwright.transform.overwrite"), "contrib/ghostty/lavi.conf" }
  )

  builder.run(
    require("lush_theme.lavi.bottom"),
    compile_palette,
    transform_toml,
    { require("shipwright.transform.overwrite"), "contrib/bottom/lavi.toml" }
  )

  builder.run(
    require("lush_theme.lavi.btop"),
    compile_palette,
    transform_btop,
    { require("shipwright.transform.overwrite"), "contrib/btop/lavi.theme" }
  )

  builder.run(
    palette,
    require("shipwright.transform.contrib.kitty"),
    { require("shipwright.transform.overwrite"), "contrib/kitty/lavi.conf" }
  )

  builder.run(
    require("lush_theme.lavi.opencode"),
    compile_palette,
    transform_json,
    { require("shipwright.transform.overwrite"), "contrib/opencode/lavi.json" }
  )

  builder.run(
    palette,
    require("shipwright.transform.contrib.wezterm"),
    { require("shipwright.transform.overwrite"), "contrib/wezterm/lavi.toml" }
  )

  builder.run(
    vim.tbl_extend("force", { name = "lavi" }, palette),
    require("shipwright.transform.contrib.windows_terminal"),
    { require("shipwright.transform.overwrite"), "contrib/windows_terminal/lavi.json" }
  )

  builder.run(
    require("lush_theme.lavi.zellij"),
    transform_kdl,
    { require("shipwright.transform.overwrite"), "contrib/zellij/lavi.kdl" }
  )

  builder.run(
    palette,
    transform_nix_ghostty,
    { require("shipwright.transform.overwrite"), "nix/themes/ghostty.nix" }
  )

  builder.run(
    palette,
    transform_nix_alacritty,
    { require("shipwright.transform.overwrite"), "nix/themes/alacritty.nix" }
  )

  builder.run(
    palette,
    transform_nix_foot,
    { require("shipwright.transform.overwrite"), "nix/themes/foot.nix" }
  )
end, {})
