#!/bin/bash -v
sudo -v

## OS X
sudo softwareupdate -i -a

## brew
cd "$(brew --prefix)"
git fetch origin
git reset --hard origin/master
brew update --all
brew cask update
brew upgrade
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
rvm fix-permissions
rvm get stable
rvm requirements
rvm rubygems latest
rvm all do sudo gem update --system
rvm all do sudo gem update
rvm all do sudo gem cleanup
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
sudo pear upgrade pear
sudo pear clear-cache
sudo pear update-channels
sudo pear upgrade

## go
go get -u github.com/nsf/gocode
go get -u all

## android
android update adb

## msf
#rvm use ruby-2.1.5@metasploit-framework
#/usr/local/share/metasploit-framework/msfupdate
#rvm use default

## finish
diskutil repairPermissions /
sudo find / -name ".DS_Store" -depth -exec rm {} \;
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder
brew cask doctor
brew doctor