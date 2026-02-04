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

With Nix flakes (see [Nix](#nix) section for more options):

```nix
programs.neovim.plugins = [
  inputs.lavi.packages.${pkgs.system}.lavi-nvim
];
```

### Alacritty

1. Copy [`contrib/alacritty/lavi.toml`](./contrib/alacritty/lavi.toml) to `~/.config/alacritty/lavi.toml`
2. Import into your Alacritty config:
   ```toml
   general.import = [
     "~/.config/alacritty/lavi.toml",
   ]
   ```

### Bottom

1. Copy the contents of [`contrib/bottom/lavi.toml`](./contrib/bottom/lavi.toml) into your `~/.config/bottom/bottom.toml`

### Btop

1. Copy [`contrib/btop/lavi.theme`](./contrib/btop/lavi.theme) to `~/.config/btop/themes/lavi.theme`
2. Set `color_theme = "lavi"` in your `~/.config/btop/btop.conf` or select it from the options menu

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

### Nix

Lavi provides a Nix flake with multiple outputs for flexible integration.

#### Flake Outputs

| Output | Description |
|--------|-------------|
| `packages.<system>.lavi-nvim` | Minimal Neovim plugin (runtime only, no lush dependency) |
| `packages.<system>.lavi-nvim-dev` | Full Neovim plugin with lush sources for customization |
| `packages.<system>.lavi-themes` | All theme files from `contrib/` |
| `lib.themes.<app>` | Raw theme content as strings (e.g., `lib.themes.ghostty`) |
| `homeManagerModules.lavi` | Home-manager module with per-app options |

#### Home-Manager Module

Add to your flake inputs:

```nix
inputs.lavi.url = "github:b0o/lavi.nvim";
```

Import and configure:

```nix
{ inputs, pkgs, ... }:
{
  imports = [ inputs.lavi.homeManagerModules.lavi ];

  lavi = {
    neovim.enable = true;    # Adds lavi-nvim to programs.neovim.plugins
    ghostty.enable = true;   # Configures programs.ghostty.themes.lavi
    alacritty.enable = true; # Merges colors into programs.alacritty.settings
    kitty.enable = true;     # Appends to programs.kitty.extraConfig
    foot.enable = true;      # Merges into programs.foot.settings
    btop.enable = true;      # Writes theme file and sets color_theme
  };
}
```

#### Manual Installation

For users who manage their own config files:

```nix
# Symlink theme files
home.file.".config/ghostty/themes/lavi.conf".source =
  "${inputs.lavi.packages.${pkgs.system}.lavi-themes}/ghostty/lavi.conf";

# Or use raw content
xdg.configFile."ghostty/themes/lavi.conf".text = inputs.lavi.lib.themes.ghostty;
```

#### Development Shell

For contributing or modifying themes:

```bash
nix develop github:b0o/lavi.nvim
lavi-generate-themes  # Regenerate all theme files
lavi-format           # Format with stylua and dprint
```

## Contributing

This colorscheme is built with [Lush.nvim](https://github.com/rktjmp/lush.nvim), ensure you have it installed.

Themes are generated from the palette and highlight definitions in `lua/lush_theme/lavi/`.
The files in other directories are automatically generated, so don't edit them directly. Re-generate the themes with `just build` (requires [just](https://github.com/casey/just)).
Format with `just fmt` - requires [StyLua](https://github.com/JohnnyMorganz/StyLua) and [dprint](https://dprint.dev/).

## License

MIT License
