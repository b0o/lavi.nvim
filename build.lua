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
end, {})
