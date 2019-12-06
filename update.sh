#!/bin/bash

# Text color variables
LG='\033[0;33m' # Yellow
NC='\033[0m'    # No Color

sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# allow alias for brew
shopt -s expand_aliases
source ~/.aliases

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# App Store and Xcode maintenance
echo -e "${LG}[1/18] Updating App Store apps${NC}"
mas outdated
mas upgrade

echo -e "${LG}[2/18] Verifying Xcode Command Line Tools${NC}"
xcode-select --install

# Homebrew maintenance
echo -e "${LG}[3/18] Updating Homebrew${NC}"
alias brew='PATH=${PATH//$(pyenv root)\/shims:/} brew'
cd "$(brew --prefix)/homebrew"
git fetch origin
git reset --hard origin/master
brew tap --repair

echo -e "${LG}[4/18] Updating Homebrew formulae${NC}"
brew update
brew upgrade

echo -e "${LG}[5/18] Updating Homebrew casks${NC}"
brew cu -a -y --cleanup

echo -e "${LG}[6/18] Recreating Homebrew Brewfile${NC}"
brew bundle dump --force

echo -e "${LG}[7/18] Cleaning up Homebrew${NC}"
brew cleanup -s
brew services cleanup

# Python maintenance
echo -e "${LG}[8/18] Updating Python packages${NC}"
pip install --upgrade pip setuptools
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
pyenv rehash

# Node.js maintenance
echo -e "${LG}[9/18] Updating Node.js packages${NC}"
nvm install-latest-npm
npm cache verify
npm update -g
nvm cache clear

# Ruby maintenance
echo -e "${LG}[10/18] Updating Ruby gems${NC}"
gem update --system
gem update
gem cleanup
rbenv rehash
bundle-audit update

# PHP maintenance
echo -e "${LG}[11/18] Updating PHP packages${NC}"
pecl install xdebug
pear clear-cache
pecl clear-cache
pear update-channels
pecl update-channels

# Go maintenance
echo -e "${LG}[12/18] Updating Go packages${NC}"
go get -u all
go clean

# Quick Look maintenance
echo -e "${LG}[13/18] Reloading Quick Look generators${NC}"
qlmanage -r
qlmanage -r cache

# MacOS system maintenance
echo -e "${LG}[14/18] Running MacOS maintenance routines${NC}"
sudo periodic daily weekly monthly

# MacOS system updates
echo -e "\n${LG}[15/18] Updating MacOS${NC}"
sudo softwareupdate -ia

# Backup dot and config files
echo -e "${LG}[16/18] Backing up dot and config files${NC}"
mackup backup -f

# Reset Launchpad
echo -e "${LG}[17/18] Resetting Launchpad${NC}"
rm ~/Library/Application\ Support/Dock/*.db
rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"
defaults write com.apple.dock ResetLaunchPad -bool true
sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder

# Final checkups
echo -e "${LG}[18/18] Running final health checks${NC}"
brew cask doctor
brew doctor
