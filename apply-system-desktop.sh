#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild switch --upgrade-all --flake .#desktop --impure --update-input nixpkgs
popd
