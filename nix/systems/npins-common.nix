{ ... }:

let
  sources = import ../npins;
in
{
  # Set flake's nixpkgs
  nix.registry.nixpkgs.to = {
    type = "path";
    path = sources.nixpkgs;
  };

  # Set <nixpkgs> and <home-manager> to track npins
  nix.nixPath = [ "nixpkgs=${sources.nixpkgs}" "home-manager=${sources.home-manager}" ];
}
