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
rvm get head
rvm requirements
rvm rubygems latest
rvm all do gem update --system
rvm all do gem update
rvm all do gem cleanup
rvm cleanup all
rvm repair all

## pip
python -m pip install --upgrade --force pip
pip install --upgrade setuptools
pip install --upgrade distribute
pip install --upgrade pip
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -I package sh -c "sudo -H pip install --upgrade --allow-external package --allow-unverified package package"

## pear
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "sudo rm /usr/local/etc/php/version/pear.conf"
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | xargs -I path sh -c "sudo chmod -R ug+w path/lib/php"
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "sudo pear config-set php_ini /usr/local/etc/php/version/php.ini system"
sudo pear config-set auto_discover 1
sudo pear upgrade pear
sudo pear clear-cache
sudo pear update-channels
sudo pear upgrade

## go
go get -u all

## android
android update adb

## security tools
bundle-audit update
nikto -update
sqlmap --update

## finish
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder
jenv rehash
jenv doctor
yo doctor
appium-doctor
brew cask doctor
brew doctor
