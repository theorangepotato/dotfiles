{pkgs, ...}:
{
  imports = [
    ./common.nix
    ./gnome.nix
  ];

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
    electrum
    zotero
    libreoffice
    # Spellcheck and dictionary for LibreOffice
    hunspell
    hunspellDicts.en_US
  ];

  programs.kitty = {
    enable = true;
    extraConfig = (builtins.readFile ../../kitty/.config/kitty/kitty.conf);
  };

  programs.joplin-desktop = {
    enable = true;
    sync = {
      target = "nextcloud";
      interval = "30m";
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "austin";
  home.homeDirectory = "/home/austin";
}
