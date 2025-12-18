# Lavi 🪻

A soft and sweet colorscheme

![Screenshot](https://github.com/user-attachments/assets/a7873a70-4b90-4e92-a11c-f262d9653f29)

## Installation

### Neovim

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'b0o/lavi.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'lavi'
  end,
},
```

### Alacritty

1. Copy [`contrib/alacritty/lavi.toml`](./contrib/alacritty/lavi.toml) to `~/.config/alacritty/lavi.toml`
2. Import into your Alacritty config:
   ```toml
   general.import = [
     "~/.config/alacritty/lavi.toml",
   ]
   ```

### Foot

1. Copy the contents of [`contrib/foot/lavi.ini`](./contrib/foot/lavi.ini) into your `~/.config/foot/foot.ini`

### Ghostty

1. Copy [`contrib/ghostty/lavi.conf`](./contrib/ghostty/lavi.conf) to `~/.config/ghostty/themes/lavi.conf`
2. Set `theme = lavi.conf` in your `~/.config/ghostty/config`

### Kitty

1. Copy the contents of [`contrib/kitty/lavi.conf`](./contrib/kitty/lavi.conf) into your `~/.config/kitty/themes/lavi.conf`
2. Run `kitty +kitten themes --reload-in=all lavi` to set the theme

### Opencode

1. Copy [`contrib/opencode/lavi.json`](./contrib/opencode/lavi.json) to `~/.config/opencode/themes/lavi.json`
2. Set `{ "theme": "lavi" }` in your `~/.config/opencode/opencode.jsonc` or select it from the UI theme picker

### Wezterm

1. Copy [`contrib/wezterm/lavi.toml`](./contrib/wezterm/lavi.toml) to `~/.config/wezterm/colors/lavi.toml`
2. Set `config.color_scheme = "lavi"` in your Wezterm config

### Windows Terminal

1. Open the Windows Terminal settings (`ctrl+,`)
2. Select **Open JSON file** at the bottom left corner (`ctrl+shift+,`)
3. Copy the contents of [`contrib/windows_terminal/lavi.json`](./contrib/windows_terminal/lavi.json) inside of the `schemes` array
   ```jsonc
   {
     "schemes": [
       // paste the contents of lavi.json here
     ],
   }
   ```
4. Save and exit
5. In the **Settings** panel under **Profiles**, select the profile you want to use the theme in, then select **Appearance** and choose **lavi** from the **Color scheme** dropdown

### Zellij

1. Copy [`contrib/zellij/lavi.kdl`](./contrib/zellij/lavi.kdl) to `~/.config/zellij/themes/lavi.kdl`
2. Set `theme "lavi"` in your `~/.config/zellij/config.kdl`

## Contributing

This colorscheme is built with [Lush.nvim](https://github.com/rktjmp/lush.nvim), ensure you have it installed.

Themes are generated from the palette and highlight definitions in `lua/lush_theme/lavi/`.
The files in other directories are automatically generated, so don't edit them directly. Re-generate the themes with `just build` (requires [just](https://github.com/casey/just)).
Format with `just fmt` - requires [StyLua](https://github.com/JohnnyMorganz/StyLua) and [dprint](https://dprint.dev/).

## License

MIT License
