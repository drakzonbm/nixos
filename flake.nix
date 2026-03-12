{
  description = "Brian's NixOS systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-openclaw.url = "github:openclaw/nix-openclaw";
  };

  outputs = { self, nixpkgs, home-manager, nix-openclaw, ... }:
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
              nixpkgs.overlays = [ nix-openclaw.overlays.default ];
            }
            ./hosts/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
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
