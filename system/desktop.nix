{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /home/mizl/.dotfiles/system/desktop-hardware-configuration.nix
    ];
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production; 
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
  };
  programs.xwayland.enable = true;
  boot = {
    kernelModules = [ "kvm-intel" "wl" "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };
  networking.hostName = "coilsum";
}
