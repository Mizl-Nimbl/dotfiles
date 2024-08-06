{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

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

  home.packages = with pkgs; [
    cider
    alacritty
    nerdfonts
    starship
    neofetch
    cmake
    vscode
    gcc
    gdb
    ninja
    libGL.dev
    libGLU
    glm
    glfw
    glbinding
    mesa
    freeglut
    direnv
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
    nmap
    vlc
    nix-prefetch-git
    discord
    cava
    prismlauncher
    reaper
    helm
    vital
    ntfs3g
    ntfsprogs
    gamemode
    vulkan-tools
    glxinfo
  ];
  
  programs.cava = {
    enable = true;
    settings = {
      input.channels = "mono";
      output.alacritty_sync = "1";
      color = {
        gradient = "1";
        gradient_color_1 = "'#cd231d'";
        gradient_color_2 = "'#d03c19'";
        gradient_color_3 = "'#d35014'";
        gradient_color_4 = "'#d56111'";
        gradient_color_5 = "'#d67010'";
        gradient_color_6 = "'#d77f13'";
        gradient_color_7 = "'#d88d19'";
        gradient_color_8 = "'#d89b22'";
      };
      general.bar_width = "3";
    };
  };

  programs.neovim = {
    enable = false;
    defaultEditor = false;
    plugins = with pkgs.vimPlugins; [
      vimwiki
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          require('neo-tree-nvim').setup {}
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            highlight = { enable = true }
          }
        '';
      }
      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = ''
          require("gruvbox").setup{}
          vim.cmd[[colorscheme gruvbox]]
        '';
      }
    ];
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
  };

  # programs.vscodium = {
  #   enable = true;
  # };

  programs.bash = {
    enable = true;
    shellAliases = {
      please = "sudo";
    };
    enableCompletion = true;
    bashrcExtra = "eval '$(starship init bash)'";
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      colors.primary = {
        # hard contrast background = = '#1d2021'
        background = "#282828";
        # soft contrast background = = '#32302f'
        foreground = "#ebdbb2";
      };
      colors.normal = {
        black   = "#282828";
        red     = "#cc241d";
        green   = "#98971a";
        yellow  = "#d79921";
        blue    = "#458588";
        magenta = "#b16286";
        cyan    = "#689d6a";
        white   = "#a89984";
      };
      colors.bright = {
        black   = "#928374";
        red     = "#fb4934";
        green   = "#b8bb26";
        yellow  = "#fabd2f";
        blue    = "#83a598";
        magenta = "#d3869b";
        cyan    = "#8ec07c";
        white   = "#ebdbb2";
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = 
        "[](color_orange)\$os\$username\[@](bg:color_orange fg:color_fg0)\$hostname[](bg:color_yellow fg:color_orange)\$directory\[](fg:color_yellow bg:color_aqua)\$git_branch\$git_status\[](fg:color_aqua bg:color_bg1)\$time\[ ](fg:color_bg1)\$line_break$character";
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
        style = "bg:color_orange fg:color_fg0";
        format = "[ $hostname ]($style)";
        disabled = false;
        ssh_only = false;
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

  programs.bash.initExtra = "clear";

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
    TERMINAL = "alacritty";
    EDITOR = "vscode";
    MOZ_ENABLE_WAYLAND = 0;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
