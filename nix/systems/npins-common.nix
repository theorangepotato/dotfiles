{ ... }:

let
  sources = import ../npins;
in
{
  # Set <nixpkgs> to track npins and set configuration to live in the git repo
  nix.registry.nixpkgs.to = {
    type = "path";
    path = sources.nixpkgs;
  };
  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];
}
