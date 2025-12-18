vim.opt.background = "dark"
vim.g.colors_name = "lavi_dev"
package.loaded["lush_theme.lavi"] = nil
require("lush")(require("lush_theme.lavi"))
