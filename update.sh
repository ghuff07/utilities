#!/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
sudo chflags norestricted /usr/local && sudo chown -R $(whoami) $(brew --prefix)/* && sudo chown -R $(whoami):staff /Users/$(whoami)

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# OSX and xcode update
sudo softwareupdate -ia
mas upgrade
xcode-select --install

# homebrew update
cd "$(brew --prefix)/homebrew"
git fetch origin
git reset --hard origin/master
brew tap --repair
brew update
brew upgrade
brew prune
brew cu -a -y --cleanup
brew cleanup -s
brew services cleanup

# homebrew relink and prune
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"
brew prune

# python2 / pip update
pip install --upgrade pip setuptools wheel
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U

# python3 / pip3 update
pip3 install --upgrade pip setuptools wheel
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U

# node.js / npm update
npm install -g npm@latest
npm cache verify
npm update -g

# bower update
bower cache clean
bower update

# rvm / ruby / gem update
rvm requirements
rvm use system
gem update --system
gem update
gem cleanup
rvm use default
rvm get head
rvm rubygems latest
rvm all do gem update --system
rvm all do gem update
rvm all do gem regenerate_binstubs
rvm all do gem cleanup
rvm cleanup all
rvm repair all

# php / pear udate
pear config-set auto_discover 1
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear install --alldeps phpmd/PHP_PMD
pear install PHP_CodeSniffer
pear install Console_GetoptPlus
pear clear-cache
pear update-channels
pear upgrade-all

# golang / go update
go get -u github.com/alecthomas/gometalinter
gometalinter --install
go get -u all

# security tool update
bundle-audit update

# mackup
#mackup -f backup

# quicklook
qlmanage -r
qlmanage -r cache

# reset launchpad
rm ~/Library/Application\ Support/Dock/*.db; rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"; defaults write com.apple.dock ResetLaunchPad -bool true; sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder

# MacOS maintenance
sudo periodic daily weekly monthly

# checkups
yo doctor
brew cask doctor
brew doctor
