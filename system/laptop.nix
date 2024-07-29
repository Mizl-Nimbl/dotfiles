{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /home/mizl/.dotfiles/system/laptop-hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  networking.hostName = "godhead";
}
