{
  description = "Brian's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      mkHost = hostName: extraModules:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self hostName;
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.drakzon = import ./home/brian.nix;
              home-manager.extraSpecialArgs = {
                inherit hostName;
              };
            }
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = {
        laptop = mkHost "laptop" [];
        desktop = mkHost "desktop" [];
        vm = mkHost "vm" [];
        gaminglaptop = mkHost "gaminglaptop" [];
      };
    };
}
