#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/mizl/home.nix
popd
