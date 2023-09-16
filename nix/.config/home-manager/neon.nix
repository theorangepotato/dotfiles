{pkgs, ...}:
{
  imports = [ ./common.nix ];

  home.packages = [
    pkgs.hello
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "austin";
  home.homeDirectory = "/home/austin";
}
