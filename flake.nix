{
  description = "mizl nixOS";
  inputs = {
      zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/shared.nix ./system/desktop.nix ];
        specialArgs = { inherit inputs; };
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/shared.nix ./system/laptop.nix ];
        specialArgs = { inherit inputs; };
      };
    };
}
