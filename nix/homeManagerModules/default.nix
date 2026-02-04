{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.lavi;

  # Build the lavi-nvim plugin using the same logic as flake.nix
  lavi-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "lavi.nvim";
    version = "0.1.0";
    src = pkgs.lib.cleanSourceWith {
      src = ../..;
      filter =
        path: type:
        let
          name = baseNameOf path;
          excluded = [
            "lush_theme"
            "lavi_dev.lua"
            "build.lua"
            "build"
            "contrib"
            "nix"
            "docs"
            "justfile"
            "dprint.json"
            ".gitignore"
            "flake.nix"
            "flake.lock"
          ];
        in
        !(builtins.elem name excluded);
    };
    meta = {
      description = "Lavi - a soft and sweet colorscheme for Neovim";
      homepage = "https://github.com/b0o/lavi.nvim";
      license = pkgs.lib.licenses.mit;
    };
  };
in
{
  options.lavi = {
    alacritty.enable = lib.mkEnableOption "Lavi theme for Alacritty";
    btop.enable = lib.mkEnableOption "Lavi theme for Btop";
    foot.enable = lib.mkEnableOption "Lavi theme for Foot";
    ghostty.enable = lib.mkEnableOption "Lavi theme for Ghostty";
    kitty.enable = lib.mkEnableOption "Lavi theme for Kitty";

    neovim = {
      enable = lib.mkEnableOption "Lavi colorscheme for Neovim";
      package = lib.mkOption {
        type = lib.types.package;
        default = lavi-nvim;
        defaultText = lib.literalExpression "lavi-nvim";
        description = "The lavi.nvim package to use.";
      };
    };
  };

  config = lib.mkMerge [
    # Alacritty - merge colors into settings
    (lib.mkIf cfg.alacritty.enable {
      programs.alacritty.settings = import ../themes/alacritty.nix;
    })

    # Btop - file-based theme, write file and set color_theme
    (lib.mkIf cfg.btop.enable {
      programs.btop.settings.color_theme = "lavi";
      xdg.configFile."btop/themes/lavi.theme".source = ../../contrib/btop/lavi.theme;
    })

    # Foot - merge settings
    (lib.mkIf cfg.foot.enable {
      programs.foot.settings = import ../themes/foot.nix;
    })

    # Ghostty - uses themes attrset
    (lib.mkIf cfg.ghostty.enable {
      programs.ghostty.themes.lavi = import ../themes/ghostty.nix;
    })

    # Kitty - extraConfig with raw content
    (lib.mkIf cfg.kitty.enable {
      programs.kitty.extraConfig = builtins.readFile ../../contrib/kitty/lavi.conf;
    })

    # Neovim - add plugin to programs.neovim.plugins
    (lib.mkIf cfg.neovim.enable {
      programs.neovim.plugins = [ cfg.neovim.package ];
    })
  ];
}
