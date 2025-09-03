{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /home/mizl/.dotfiles/system/desktop-hardware-configuration.nix
      /home/mizl/musnix-master
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
  # KDE Plasma 6 Chromium Flicker Fix
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services = { 
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      #Gnome
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    # KDE Plasma 6
    # displayManager.sddm.enable = true;
    # displayManager.sddm.wayland.enable = true;
    # desktopManager.plasma6.enable = true;
  };
  programs.xwayland.enable = true;
  boot = {
    kernelModules = [ "kvm-intel" "wl" "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta v4l2loopback ];
    extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
  security = {
    polkit.enable = true;
  };
  networking.hostName = "coilsum";
}
