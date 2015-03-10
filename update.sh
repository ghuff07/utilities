#!/bin/bash -v
sudo -v

## OS X
sudo softwareupdate -i -a

## brew
cd "$(brew --prefix)"
git fetch origin
git reset --hard origin/master
brew update
brew cask update
brew upgrade
for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done
brew linkapps
brew cleanup
brew cask cleanup

## relink brew kegs
brew prune
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"

## npm
npm install -g npm@latest
npm cache clean
npm update -g
sudo chown -R "$(whoami)" ~/.npm
sudo chown -R "$(whoami)" /usr/local

## rvm
rvm fix-permissions
rvm get stable --auto-dotfiles
rvm requirements
rvm cleanup all
rvm repair all

## ruby gems
gem update --system
gem update
gem cleanup
gem regenerate_binstubs

## pip
python -m pip install --upgrade --force pip
pip install --upgrade setuptools
pip install --upgrade distribute
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -I package sh -c "pip install --upgrade --allow-external package --allow-unverified package package"

## pear
pear clear-cache
pear update-channels
pear upgrade

## go
go get -u all

## finish
diskutil repairPermissions /
brew doctor
rm ~/Library/Application\ Support/Dock/*.db; defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock