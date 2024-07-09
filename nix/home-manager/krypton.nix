{pkgs, ...}:
{
  imports = [
    ./common.nix
    ./gnome.nix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = ["firefox.desktop" "kitty.desktop" "nautilus.desktop" "steam.desktop" "org.prismlauncher.PrismLauncher.desktop" "net.lutris.Lutris.desktop"];
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/privacy" = {
      old-files-age = 30;
      recent-files-max-age = -1;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/desktop/session" = {
      idle-delay = 900;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 1800;
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    restic
    prismlauncher
    lutris
    jstest-gtk
    dolphin-emu
  ];

  programs.kitty = {
    enable = true;
    extraConfig = (builtins.readFile ../../kitty/.config/kitty/kitty.conf);
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "krypton";
  home.homeDirectory = "/home/krypton";
}
