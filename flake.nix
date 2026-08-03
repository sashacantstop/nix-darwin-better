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