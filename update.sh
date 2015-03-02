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
sudo brew cleanup
sudo brew cask cleanup

## relink brew kegs
brew prune
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"

## npm
npm install -g npm@latest
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
python -m pip install --upgrade --force pip
pip install --upgrade setuptools
pip install --upgrade distribute
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -I package sh -c "pip install --upgrade --allow-external package --allow-unverified package package"

## pear
pear update-channels
sudo pear upgrade-all

## finish
diskutil repairPermissions /
brew doctor
rm ~/Library/Application\ Support/Dock/*.db; defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock