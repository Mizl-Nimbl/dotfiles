{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /home/mizl/.dotfiles/system/laptop-hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.xserver.digimend.enable = true;
  networking.hostName = "godhead";
  hardware.opentabletdriver.enable = true;
  environment.systemPackages = [
    config.boot.kernelPackages.digimend
    inputs.zen-browser.packages."${pkgs.system}".generic
  ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  i18n.inputMethod = {
    enabled = "ibus";
  };
}
