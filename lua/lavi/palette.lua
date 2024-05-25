local lush = require("lush")
local hsl = lush.hsl

local M = {}

M.bg = hsl("#25213B")
M.bg_dark = M.bg.darken(10)
M.bg_med = M.bg.lighten(13)
M.bg_bright = M.bg.lighten(20)

M.fg = hsl("#FFF1E0")
M.fg_dim = hsl("#DED4FD")
M.fg_nc = hsl("#A89CCF")

M.black = hsl("#2F2A38")
M.black_med = hsl("#4C435C")
M.black_bright = hsl("#8977A8")

M.white = hsl("#EEE6FF")
M.white_bright = hsl("#ffffff")

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
M.deep_licorice = M.bg
M.deep_anise = hsl("#564D82")
M.deep_velvet = hsl("#8F8FB3")

M.light_lavender = hsl("#EAD6FF")

return M
