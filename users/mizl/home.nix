{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mizl";
  home.homeDirectory = "/home/mizl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.sessionVariables.GTK_THEME = "gruvbox";
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    alacritty
    nerdfonts
    starship
    neofetch
    vscode
    cmake
    gcc
    gdb
    ninja
    libGL.dev
    libGLU
    glm
    glfw
    glbinding
    mesa
    git
    git-crypt
    gnupg
    pinentry-curses
    kdenlive
    krita
    obsidian
    gnome3.gnome-tweaks
    gruvbox-gtk-theme
    gruvbox-plus-icons
    capitaine-cursors-themed
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.gpg = {
    enable= true;
  };

  services.gpg-agent = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      please = "sudo";
    };
    enableCompletion = true;
    bashrcExtra = "eval '$(starship init bash)'";
  };

  programs.starship = {
    enable = true;
    settings = {
      format = 
        "[](color_orange)\$os\$username\$hostname[](bg:color_yellow fg:color_orange)\$directory\[](fg:color_yellow bg:color_aqua)\$git_branch\$git_status\[](fg:color_aqua bg:color_bg1)\$time\[ ](fg:color_bg1)\$line_break$character";
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
      };
      os.symbols = {
        NixOS = "♄";
      };
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };
      hostname = {
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $hostname ]($style)";
      };
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Pictures" = " ";
        "Developer" = "󰲋 ";
      };
      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      character = {
        success_symbol = "[➤](bold green)";
        error_symbol = "[➤](bold red)";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/alacritty/alacritty.yaml".text = ''
      shell = "/bin/bash"
      [window]
      opacity = 0.7
      blur = true
      '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mizl/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
