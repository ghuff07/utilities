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
rvm rubygems latest
rvm all do gem update --system
rvm all do gem update
rvm all do gem regenerate_binstubs
rvm all do gem cleanup
rvm cleanup all
rvm repair all

# pip
pip install --upgrade pip setuptools
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U

# pip3
pip3 install --upgrade pip setuptools wheel
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U

# pear
#brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "rm /usr/local/etc/php/version/pear.conf"
brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | xargs -I path sh -c "chmod -R ug+w path/lib/php"
brew info php70 | grep /usr/local/Cellar/php70 | head -n1 | cut -d \  -f 1 | cut -c25-27 | xargs -I version sh -c "pear config-set php_ini /usr/local/etc/php/version/php.ini system"
pear config-set auto_discover 1
pear upgrade pear
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear install --alldeps phpmd/PHP_PMD
pear install PHP_CodeSniffer
pear clear-cache
pear update-channels
pear upgrade

# go
gometalinter --install --update
go get -u all

# java
#if which jenv > /dev/null; then eval "$(jenv init -)"; fi
#jenv rehash
#jenv enable-plugin export

# security tools
bundle-audit update

# reset launchpad
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder

# various checkups
#jenv doctor
yo doctor
brew cask doctor
brew doctor
