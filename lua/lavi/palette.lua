local lush = require("lush")
local hsl = lush.hsl

local M = {}

M.black = hsl("#2F2A38")
M.black_med = hsl("#4C435C")
M.black_bright = hsl("#8977A8")

M.white = hsl("#EEE6FF")
M.white_bright = hsl("#ffffff")

M.dark_bg = hsl("#25213B")
M.dark_bg_dark = M.dark_bg.darken(10)
M.dark_bg_med = M.dark_bg.lighten(13)
M.dark_bg_bright = M.dark_bg.lighten(20)

M.light_bg = M.white_bright
M.light_bg_med = M.light_bg.darken(5)
M.light_bg_dark = M.light_bg.darken(10)
M.light_bg_bright = M.light_bg.lighten(20)

M.light_fg = M.black.lighten(5)
M.light_fg_dim = M.light_fg.lighten(20)
M.light_fg_nc = M.light_fg.lighten(40)

M.dark_fg = hsl("#FFF1E0")
M.dark_fg_dim = hsl("#DED4FD")
M.dark_fg_nc = hsl("#A89CCF")

local function set_fg_bg()
  local dark_mode = vim.g.colors_name == 'lavi'
  M.fg = dark_mode and M.dark_fg or M.light_fg
  M.fg_dim = dark_mode and M.dark_fg_dim or M.light_fg_dim
  M.fg_nc = dark_mode and M.dark_fg_nc or M.light_fg_nc

  M.bg = dark_mode and M.dark_bg or M.light_bg
  M.bg_dark = dark_mode and M.dark_bg_dark or M.light_bg_dark
  M.bg_med = dark_mode and M.dark_bg_med or M.light_bg_med
  M.bg_bright = dark_mode and M.dark_bg_bright or M.light_bg_bright
end

set_fg_bg()

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "*",
  callback = function()
    set_fg_bg()
  end,
})

M.skyblue = hsl("#3FC4C4")
M.cyan = hsl("#2BEDC0")

M.red = hsl("#F2637E")
M.orange = hsl("#ff9969")
M.yellow = hsl("#FFD080")
M.green = hsl("#7CF89C")
M.blue = hsl("#7583FF")
M.indigo = hsl("#9074FF")
M.violet = hsl("#DC91FF")

M.oceanblue = hsl("#80BDFF")
M.magenta = hsl("#B98AFF")
M.red_bright = hsl("#FF87A5")
M.violet_bright = hsl("#B891FF")
M.violet_med = hsl("#9385F8")

M.straw = hsl("#fffacf")

M.tofu = hsl("#fdf6e3")
M.cashew = hsl("#e6dac3")
M.walnut = hsl("#CEB999")
M.almond = hsl("#a6875a")
M.cocoa = hsl("#3b290e")

M.licorice = hsl("#483270")
M.lavender = hsl("#A872FB")
M.velvet = hsl("#B29EED")
M.anise = hsl("#7F7DEE")
M.anise_dark = hsl("#7E7490")
M.hydrangea = hsl("#fb72fa")
M.blush = hsl("#EBBBF9")
M.powder = hsl("#EAC6F5")
M.dust = hsl("#EAD2F1")
M.mistyrose = hsl("#ffe4e1")
M.rebeccapurple = hsl("#3C2C74")

M.matcha = hsl("#9fdfb4")

M.snow = hsl("#e4fffe")
M.ice = hsl("#a4e2e0")
M.mint = hsl("#a2e0ca")

M.nectar = hsl("#f0f070")
M.cayenne = hsl("#FF7D90")
M.yam = hsl("#e86f54")
M.pumpkin = hsl("#ff9969") -- TODO
M.rose = hsl("#b32e29")

M.grey2 = hsl("#222222")
M.grey5 = hsl("#777777")
M.grey6 = hsl("#aaaaaa")
M.grey7 = hsl("#cccccc")
M.grey8 = hsl("#dddddd")

M.mid_velvet = hsl("#6E6EA3")

M.deep_lavender = hsl("#38265A")
M.deep_licorice = M.dark_bg
M.deep_anise = hsl("#564D82")
M.deep_velvet = hsl("#8F8FB3")

M.light_lavender = hsl("#EAD6FF")

return M
