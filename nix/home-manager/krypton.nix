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
    prismlauncher
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
