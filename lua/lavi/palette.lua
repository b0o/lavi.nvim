local lush = require("lush")
local hsl = lush.hsl

return {
  bg = hsl("#201C33"),
  bg_dark = hsl("#201C33").darken(10),
  bg_med = hsl("#201C33").lighten(13),
  bg_bright = hsl("#201C33").lighten(20),

  fg = hsl("#FFF1E0"),

  black = hsl("#2F2A38"),
  black_med = hsl("#4C435C"),
  black_bright = hsl("#8977A8"),

  white = hsl("#EEE6FF"),
  white_bright = hsl("#ffffff"),

  skyblue = hsl("#3FC4C4"),
  cyan = hsl("#2BEDC0"),

  red = hsl("#F2637E"),
  orange = hsl("#ff9969"),
  yellow = hsl("#FFD080"),
  green = hsl("#7CF89C"),
  blue = hsl("#7583FF"),
  indigo = hsl("#9074FF"),
  violet = hsl("#DC91FF"),

  oceanblue = hsl("#80BDFF"),
  magenta = hsl("#B98AFF"),
  red_bright = hsl("#FF87A5"),
  violet_bright = hsl("#B891FF"),
  violet_med = hsl("#9385F8"),

  straw = hsl("#fffacf"),

  tofu = hsl("#fdf6e3"),
  cashew = hsl("#e6dac3"),
  walnut = hsl("#CEB999"),
  almond = hsl("#a6875a"),
  cocoa = hsl("#3b290e"),

  licorice = hsl("#483270"),
  lavender = hsl("#A872FB"),
  velvet = hsl("#B29EED"),
  anise = hsl("#7F7DEE"),
  anise_dark = hsl("#7E7490"),
  hydrangea = hsl("#fb72fa"),
  blush = hsl("#EBBBF9"),
  powder = hsl("#EAC6F5"),
  dust = hsl("#EAD2F1"),
  mistyrose = hsl("#ffe4e1"),
  rebeccapurple = hsl("#3C2C74"),

  matcha = hsl("#9fdfb4"),

  snow = hsl("#e4fffe"),
  ice = hsl("#a4e2e0"),
  mint = hsl("#a2e0ca"),

  nectar = hsl("#f0f070"),
  cayenne = hsl("#FF7D90"),
  yam = hsl("#e86f54"),
  pumpkin = hsl("#ff9969"), -- TODO
  rose = hsl("#b32e29"),

  grey2 = hsl("#222222"),
  grey5 = hsl("#777777"),
  grey6 = hsl("#aaaaaa"),
  grey7 = hsl("#cccccc"),
  grey8 = hsl("#dddddd"),

  mid_velvet = hsl("#6E6EA3"),

  deep_lavender = hsl("#38265A"),
  deep_licorice = hsl("#201C33"),
  deep_anise = hsl("#564D82"),
  deep_velvet = hsl("#8F8FB3"),

  light_lavender = hsl("#EAD6FF"),
}
