#!/usr/bin/env bash

# Comes from https://jade.fyi/blog/pinning-nixos-with-npins/

cd $(dirname $0)

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
shift

echo "Evaluating nixpkgs..."
nixpkgs_pin=$(nix eval --raw -f ../../npins/default.nix nixpkgs)
echo "Evaluating home-manager..."
homemanager_pin=$(nix eval --raw -f ../../npins/default.nix home-manager)
echo "Evaluating nix-on-droid..."
nixondroid_pin=$(nix eval --raw -f ../../npins/default.nix nix-on-droid)

nix_path="nixpkgs=${nixpkgs_pin}:home-manager=${homemanager_pin}:nix-on-droid=${nixondroid_pin}:nixos-config=${PWD}/configuration.nix"

# without --fast, nix-on-droid will compile nix and use the compiled nix to
# evaluate the config, wasting several seconds
echo "Performing $cmd..."
NIX_PATH="${nix_path}" nix-on-droid -f ./configuration.nix "$cmd" "$@"
