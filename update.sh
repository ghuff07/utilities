#!/bin/bash -v
sudo -v

## MacOSX
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
npm-check-updates -g
read -p "Update packages manually and press any key... " -n 1
sudo chown -R "$(whoami)" ~/.npm
sudo chown -R "$(whoami)" /usr/local

## rvm
rvm get stable

## ruby
sudo gem update --system
sudo gem update
sudo gem cleanup

# finish
diskutil repairPermissions /
brew doctor
read -p "Fixed problem and press any key... " -n 1