#!/bin/bash -v
sudo -v

## OS X
sudo softwareupdate -i -a

## brew
cd "$(brew --prefix)"
git fetch origin
git reset --hard origin/master
brew update
brew upgrade
sudo brew cleanup

## npm
sudo npm cache clean
sudo npm update -g
sudo chown -R "$(whoami)" ~/.npm
sudo chown -R "$(whoami)" /usr/local

## rvm
rvm get stable --auto-dotfiles
rvm requirements

## ruby gems
sudo gem update --system
sudo gem update
sudo gem cleanup

## pip
pip install --upgrade distribute
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U

## finish
diskutil repairPermissions /
brew doctor