{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      inherit (builtins) attrNames elem mapAttrs;
      inherit (nixpkgs.lib) getName;
      pkgx = import nixpkgs {
        system = "x86_64-darwin";
        config.allowUnfreePredicate = pkg: elem (getName pkg) [
          "rar"
        ];
      };

      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgx; [
          bat
          chezmoi
          direnv
          exercism
          eza
          fd
          flyctl
          fop
          fzf
          git-delete-merged-branches
          htop
          lazygit
          nixpkgs-fmt
          procs
          rar
          ripgrep
          sd
          tealdeer
          typos
          yq
          zoxide
          pkgs.fish
          pkgs.go-task
          pkgs.hyperfine
          pkgs.starship
        ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # nixpkgs.hostPlatform = "x86_64-darwin";
        nixpkgs.hostPlatform = "aarch64-darwin";

        security.pam.enableSudoTouchIdAuth = true;

        launchd = {
          user = {
            agents = mapAttrs (key: agent: agent // { serviceConfig.RunAtLoad = true; }) {
              aerospace.command = "open -a Aerospace.app";
              linearMouse.command = "open -a LinearMouse.app";
              postgres.command = "open -a Postgres.app";
            };
          };
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."simple".pkgs;
    };
}
