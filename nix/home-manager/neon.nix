{pkgs, lib, ...}:
# https://github.com/nix-community/home-manager/issues/3447#issuecomment-2213029759
let autostartPrograms = prgms: builtins.listToAttrs (map
    (pkg: {
      name = ".config/autostart/" + pkg.pname + ".desktop";
      value =
        if pkg ? desktopItem
        then {
          # Application has a desktopItem entry.
          # Assume that it was made with makeDesktopEntry, which exposes a
          # text attribute with the contents of the .desktop file
          text = pkg.desktopItem.text;
        }
        else {
          # Application does *not* have a desktopItem entry. Try to find a
          # matching .desktop name in /share/applications
          source = with builtins; let
            appsPath = "${pkg}/share/applications";
            # function to filter out subdirs of /share/applications
            filterFiles = dirContents: lib.attrsets.filterAttrs (_: fileType: elem fileType ["regular" "symlink"]) dirContents;
          in (
            # if there's a desktop file by the app's pname, use that
            if (pathExists "${appsPath}/${pkg.pname}.desktop")
            then "${appsPath}/${pkg.pname}.desktop"
            # if there's not, find the first desktop file in the app's directory and assume that's good enough
            else
              (
                if pathExists "${appsPath}"
                then "${appsPath}/${head (attrNames (filterFiles (readDir "${appsPath}")))}"
                else throw "no desktop file for app ${pkg.pname}"
              )
          );
        };
    })
    prgms);
in
{
  imports = [
    ./common.nix
    ./gnome.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    /* google-chrome */
    chromium
    restic
    keepassxc
    signal-desktop
    evolution
    nextcloud-client
    calibre
    prismlauncher
    electrum
    zotero
    qjackctl
    sshuttle
    transmission_4-gtk
    mpv
    vlc
    spotify
    planify
    gnomeExtensions.gsconnect
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

  home.file = {
    ".config/evolution/accels".source = ../../evolution/.config/evolution/accels;
  } // autostartPrograms [ pkgs.keepassxc pkgs.signal-desktop pkgs.nextcloud-client pkgs.joplin-desktop pkgs.evolution ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "austin";
  home.homeDirectory = "/home/austin";
}
