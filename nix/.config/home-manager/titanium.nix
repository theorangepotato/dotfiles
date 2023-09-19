{pkgs, ...}:
{
  imports = [ ./common.nix ];

  programs.fish.shellInit = (builtins.readFile ../../../fish/.config/fish/config.fish);
  programs.fish.interactiveShellInit = "set -g fish_greeting";
}
