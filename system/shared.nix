# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  services.flatpak.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  # hardware.opengl.setLdLibraryPath = true;
  # Bootloader.
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xwayland
  ];
   # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration
  #   konsole
  #   ark
  #   elisa
  #   gwenview
  #   okular
  #   kate
  #   khelpcenter
  #   dolphin
  #   baloo-widgets
  #   dolphin-plugins
  #   spectacle
  #   ffmpegthumbs
  #   krdp
  # ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # mouse
  services.ratbagd.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire.adjust-sample-rate = {
        "context.properties" = {
            "default.clock.rate" = 192000;
            "default.allowed-rates" = [ 192000 ];
        };
    };
    extraConfig.pipewire-pulse = {
      "10-adjust-quirk-rules" = {
        "pulse.rules" = [
          {
            actions = {
              quirks = [
                "block-source-volume"
              ];
            };
            matches = [
              {
                "client.name" = "Discord";
              }
            ];
          }
        ];
      };
    };
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  users.extraGroups.vboxusers.members = [ "mizl" ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.extraUsers.mizl.extraGroups = [ "jackaudio" "audio" "gamemode" "dialout" "vboxusers" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mizl = {
    isNormalUser = true;
    description = "Mizl Nimbl";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.gamemode.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    mullvad-vpn
    steam
    iptables
    gamemode
    ffmpeg
    gphoto2
    mpv
    psensor
    tuxclocker
    # nautilus File manager missing fix for KDE
    libratbag
    piper
  ]; 
  
  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.gnome-console
  ];
  services.gnome.at-spi2-core.enable = true;

  programs.steam = {
    enable = true;
  };
 
  environment.variables = {
    LV2_PATH    = "/home/mizl/.nix-profile/lib/lv2";
    LXVST_PATH  = "/home/mizl/.nix-profile/lib/lxvst";
    # KWIN_DRM_NO_AMS = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}


