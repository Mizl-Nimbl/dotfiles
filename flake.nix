{
  description = "mizl nixOS";
  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/shared.nix ./system/desktop.nix ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/shared.nix ./system/laptop.nix ];
      };
    };
}