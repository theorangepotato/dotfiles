{pkgs, ...}:
let
background_image = ../../../artifacts/axolotl-devbang.jpeg;
in
{
  imports = [ ./common.nix ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    restic
    keepassxc
    signal-desktop
    evolution
    nextcloud-client
    calibre
    prismlauncher
    libreoffice
    # Spellcheck and dictionary for LibreOffice
    hunspell
    hunspellDicts.en_US
  ];

  programs.kitty = {
    enable = true;
    extraConfig = (builtins.readFile ../../../kitty/.config/kitty/kitty.conf);
  };

  programs.fish = {
    interactiveShellInit = builtins.concatStringsSep "\n" [
      (builtins.readFile ../../../generic/.aliases)
      "fish_vi_key_bindings"
      "set -g fish_greeting"
    ];
  };

  programs.joplin-desktop = {
    enable = true;
    sync = {
      target = "nextcloud";
      interval = "30m";
    };
  };

  # https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = ["firefox.desktop" "kitty.desktop" "nautilus.desktop"];
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file://${background_image}";
      picture-uri-dark = "file://${background_image}";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file://${background_image}";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/wm/keybindings" = {
      show-desktop = [ "<Super>d" ];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      speed = 0.2;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      play = [ "Favorites" ];
      home = [ "<Super>e" ];
      custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Kitty";
      command = "kitty";
      binding = "<Alt>t";
    };
  };


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "austin";
  home.homeDirectory = "/home/austin";
}
