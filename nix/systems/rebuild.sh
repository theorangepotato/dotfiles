#!/usr/bin/env bash

# Comes from https://jade.fyi/blog/pinning-nixos-with-npins/

cd $(dirname $0)

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
shift

echo "Evaluating nixpkgs..."
nixpkgs_pin=$(nix eval --raw -f ../npins/default.nix nixpkgs)
echo "Evaluating home-manager..."
homemanager_pin=$(nix eval --raw -f ../npins/default.nix home-manager)
echo "Evaluating nixos-hardware..."
nixoshardware_pin=$(nix eval --raw -f ../npins/default.nix nixos-hardware)

nix_path="nixpkgs=${nixpkgs_pin}:home-manager=${homemanager_pin}:nixos-hardware=${nixoshardware_pin}:nixos-config=${PWD}/$(hostname)/configuration.nix"

# without --no-reexec, nixos-rebuild will compile nix and use the compiled nix to
# evaluate the config, wasting several seconds
echo "Performing $cmd..."
sudo env NIX_PATH="${nix_path}" nixos-rebuild "$cmd" --no-reexec "$@"
