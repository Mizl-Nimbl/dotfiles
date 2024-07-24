#!/bin/sh
pushd ~/.dotfiles
git add .
git commit -m "Change"
git push -u origin main
popd
