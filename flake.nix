{
    description = "base for future multi-platform nix config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nixpkgs.stable-url = "github:NixOS/nixpkgs";

        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, home-manage, ... }: {
        darwinConfigurations."HOSTNAME" = nix-darwin.lib.darwinSystem {
            system = "aarch64.darwin";
            modules = [
								./hosts/macbook-neo/default.nix
								./users/sfaye/default.nix
								./users/sfaye/packages.nix
								./users/sfaye/home.nix
								./profiles/base.nix
								# ./modules/common/XXXX
								./modules/darwin/default.nix
								./modules/darwin/homebrew.nix
								./modules/darwin/security.nix
								./modules/home/desktop/gpg.nix
								./modules/home/desktop/ssh.git
								./modules/home/development/git.nix
								./modules/home/shell/fish.nix
								./modules/home/terminal/alacritty.nix
                home-manager.darwinModules.home-manager 
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        backupFileExtension = "bak";
                        extraSpecialArgs = { inherit inputs; }
                        users.USERNAME = {
                            imports = [
                            ];
                        };
                    };
                }
            ];
        };
    };
}