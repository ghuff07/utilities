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
brew upgrade --all
for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done
brew linkapps
sudo brew cleanup
sudo brew cask cleanup

## relink brew kegs
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"
brew prune

## npm
npm install -g npm@latest
npm cache clean
npm update -g
sudo chown -R "$(whoami)" ~/.npm
sudo chown -R "$(whoami)" /usr/local

## rvm
#rvm fix-permissions
rvm get stable
rvm requirements
rvm rubygems latest
rvm all do sudo gem update --system
rvm all do sudo gem update
rvm all do sudo gem cleanup
rvm all do sudo gem rdoc --all
rvm all do sudo gem pristine --all
rvm all do sudo gem regenerate_binstubs
rvm cleanup all
rvm repair all

## ruby gems
bundle-audit update

## pip
python -m pip install --upgrade --force pip
pip install --upgrade setuptools
pip install --upgrade distribute
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -I package sh -c "pip install --upgrade --allow-external package --allow-unverified package package"

## pear
php --version | head -n1 | cut -d \  -f 2 | cut -c1-3 | xargs -I version sh -c "rm /usr/local/etc/php/version/pear.conf"
#rm /usr/local/etc/php/5.6/pear.conf
php --version | head -n1 | cut -d \  -f 2 | xargs -I version sh -c "sudo chmod -R ug+w /usr/local/Cellar/php56/version/lib/php"
#sudo chmod -R ug+w /usr/local/Cellar/php56/5.6.10/lib/php
php --version | head -n1 | cut -d \  -f 2 | cut -c1-3 | xargs -I version sh -c "pear config-set php_ini /usr/local/etc/php/version/php.ini system"
#pear config-set php_ini /usr/local/etc/php/5.6/php.ini system
sudo pear config-set auto_discover 1
sudo pear upgrade pear
sudo pear clear-cache
sudo pear update-channels
sudo pear upgrade

## go
go get -u all

## android
android update adb

## finish
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder
brew cask doctor
brew doctor
