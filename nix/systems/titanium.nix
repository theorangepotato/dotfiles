{ config, lib, pkgs, ... }:
let
  sources = import ../npins;
in
{
  imports = [
    ./npins-common.nix
  ];

  # Set NIX_PATH
  nix.nixPath = [ ("nixos-config=" + toString ./. + "/titanium.nix") "nix-on-droid=${sources.nix-on-droid}" ];

  # Packages to install system-wide
  environment.packages = with pkgs; [
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  home-manager = {
    #  useGlobalPkgs = true;

    config = ../home-manager/titanium.nix;
  };

  # Set your time zone
  time.timeZone = "NorthAmerica/LosAngeles";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.05";
}
