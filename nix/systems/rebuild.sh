#!/usr/bin/env bash

# Comes from https://jade.fyi/blog/pinning-nixos-with-npins/

cd $(dirname $0)

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
shift

nixpkgs_pin=$(nix eval --raw -f ../npins/default.nix nixpkgs)
homemanager_pin=$(nix eval --raw -f ../npins/default.nix home-manager)
nix_path="nixpkgs=${nixpkgs_pin}:home-manager=${homemanager_pin}:nixos-config=${PWD}/$(hostname)/configuration.nix"

# without --fast, nixos-rebuild will compile nix and use the compiled nix to
# evaluate the config, wasting several seconds
sudo env NIX_PATH="${nix_path}" nixos-rebuild "$cmd" --fast "$@"
