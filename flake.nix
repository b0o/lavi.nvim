{
  description = "Lavi - a soft and sweet colorscheme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      # System-independent outputs
      systemIndependent = {
        # Home-manager module
        homeManagerModules.default = import ./nix/homeManagerModules;
        homeManagerModules.lavi = self.homeManagerModules.default;

        # Raw theme content as strings for programmatic access
        lib.themes = {
          alacritty = builtins.readFile ./contrib/alacritty/lavi.toml;
          bottom = builtins.readFile ./contrib/bottom/lavi.toml;
          btop = builtins.readFile ./contrib/btop/lavi.theme;
          foot = builtins.readFile ./contrib/foot/lavi.ini;
          ghostty = builtins.readFile ./contrib/ghostty/lavi.conf;
          kitty = builtins.readFile ./contrib/kitty/lavi.conf;
          opencode = builtins.readFile ./contrib/opencode/lavi.json;
          wezterm = builtins.readFile ./contrib/wezterm/lavi.toml;
          windows_terminal = builtins.readFile ./contrib/windows_terminal/lavi.json;
          zellij = builtins.readFile ./contrib/zellij/lavi.kdl;
        };
      };

      # System-dependent outputs
      systemDependent = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # Theme files package
          lavi-themes = pkgs.stdenvNoCC.mkDerivation {
            pname = "lavi-themes";
            version = "0.1.0";
            src = ./contrib;
            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp -r . $out/
              runHook postInstall
            '';
            meta = {
              description = "Lavi - a soft and sweet colorscheme";
              homepage = "https://github.com/b0o/lavi.nvim";
              license = pkgs.lib.licenses.mit;
            };
          };

          # Neovim plugin - minimal runtime (no lush dependency)
          lavi-nvim = pkgs.vimUtils.buildVimPlugin {
            pname = "lavi.nvim";
            version = "0.1.0";
            src = pkgs.lib.cleanSourceWith {
              src = ./.;
              filter =
                path: type:
                let
                  name = baseNameOf path;
                  # Exclude dev-only files that require lush
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

          # Neovim plugin - full source for development/customization (requires lush.nvim)
          lavi-nvim-dev = pkgs.vimUtils.buildVimPlugin {
            pname = "lavi.nvim-dev";
            version = "0.1.0";
            src = ./.;
            # Disable require check - lush_theme modules require lush.nvim
            doCheck = false;
            meta = {
              description = "Lavi - a soft and sweet colorscheme for Neovim (development version with lush sources)";
              homepage = "https://github.com/b0o/lavi.nvim";
              license = pkgs.lib.licenses.mit;
            };
          };

          # Build dependencies for theme generation
          buildDeps = with pkgs; [
            neovim
            stylua
            dprint
          ];

          generate-themes = pkgs.writeShellScriptBin "lavi-generate-themes" ''
            set -e
            cd "$(git rev-parse --show-toplevel)"
            nvim --headless -u build.lua +LaviBuild +q
            echo "Themes generated successfully"
          '';

          format = pkgs.writeShellScriptBin "lavi-format" ''
            set -e
            cd "$(git rev-parse --show-toplevel)"
            stylua .
            dprint fmt
            echo "Formatting complete"
          '';
        in
        {
          packages = {
            default = lavi-themes;
            inherit
              lavi-themes
              lavi-nvim
              lavi-nvim-dev
              generate-themes
              format
              ;
          };

          devShells.default = pkgs.mkShell {
            buildInputs = buildDeps ++ [
              generate-themes
              format
            ];

            shellHook = ''
              echo "Lavi development shell"
              echo ""
              echo "Commands:"
              echo "  lavi-generate-themes  - Regenerate all theme files"
              echo "  lavi-format           - Format code with stylua and dprint"
              echo "  nvim -u build.lua     - Open Neovim with Lush for interactive development"
              echo ""
            '';
          };
        }
      );
    in
    systemIndependent // systemDependent;
}
