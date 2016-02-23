#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
sudo chflags norestricted /usr/local && sudo chown -R $(whoami):admin /usr/local && sudo chown -R $(whoami):staff /Users/$(whoami)

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# OS X
sudo softwareupdate -ia
xcode-select --install

# homebrew
cd "$(brew --prefix)"
git fetch origin
git reset --hard origin/master
brew update
brew cask update
brew unlink php56
brew unlink php70
brew upgrade --all
for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done
brew linkapps
brew cleanup --force
brew cask cleanup --force
brew services cleanup

# relink brew kegs
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"
brew prune

# npm
npm install -g npm@latest
npm cache clean
npm update -g

# bower
bower cache clean
bower update

# rvm
rvm get head
rvm requirements
rvm rubygems latest
rvm all do gem update --system
rvm all do gem update
rvm all do gem regenerate_binstubs
rvm all do gem cleanup
rvm cleanup all
rvm repair all

# pip
pip install --upgrade pip setuptools
pip install --upgrade distribute
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U

# pip3
pip3 install --upgrade pip setuptools
pip3 install --upgrade distribute
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U

# pear
source $(brew --prefix php-version)/php-version.sh && php-version 5
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "sudo rm /usr/local/etc/php/version/pear.conf"
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | xargs -I path sh -c "sudo chmod -R ug+w path/lib/php"
brew info php56 | grep /usr/local/Cellar/php56 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "pear config-set php_ini /usr/local/etc/php/version/php.ini system"
pear config-set auto_discover 1
pear upgrade pear
pear clear-cache
pear update-channels
pear upgrade

source $(brew --prefix php-version)/php-version.sh && php-version 7
brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "sudo rm /usr/local/etc/php/version/pear.conf"
brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | xargs -I path sh -c "sudo chmod -R ug+w path/lib/php"
brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "pear config-set php_ini /usr/local/etc/php/version/php.ini system"
pear config-set auto_discover 1
pear upgrade pear
pear clear-cache
pear update-channels
pear upgrade

# composer
composer self-update

# go
go get -u all

# android
android update adb

# heroku
heroku update

# java
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
jenv rehash
jenv enable-plugin export

# python
pyenv rehash

# quicklook
qlmanage -r cache
qlmanage -r

# security tools
bundle-audit update
nikto -update
sqlmap --update

# reset launchpad
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder

# unhide /opt folder
sudo chflags nohidden /opt

# various checkups
chef verify
jenv doctor
yo doctor
appium-doctor
brew cask doctor
brew doctor
