#!/bin/bash

sudo -v

# Text color variables
LG='\033[0;33m' # Yellow
NC='\033[0m'    # No Color

# allow alias for brew
shopt -s expand_aliases
source ~/.aliases

# App Store and Xcode maintenance
echo -e "${LG}[1/19] Updating App Store apps${NC}"
mas outdated
mas upgrade

echo -e "${LG}[2/19] Verifying Xcode Command Line Tools${NC}"
xcode-select --install
xcrun simctl delete unavailable

# Homebrew maintenance
echo -e "${LG}[3/19] Prepping Homebrew${NC}"
alias brew='PATH=${PATH//$(pyenv root)\/shims:/} brew'
brew tap --repair
brew completions link

echo -e "${LG}[4/19] Updating Homebrew formulae${NC}"
brew update
brew upgrade

echo -e "${LG}[5/19] Updating Homebrew casks${NC}"
brew cu -a -y --no-quarantine --cleanup

echo -e "${LG}[6/19] Recreating Homebrew Brewfile${NC}"
brew bundle dump --force

echo -e "${LG}[7/19] Cleaning up Homebrew${NC}"
brew cleanup -s
brew services cleanup

# dev environment maintenance
echo -e "${LG}[8/19] Updating **envs and shims${NC}"
anyenv install --update
anyenv update
goenv rehash
jenv rehash
nodenv rehash
pyenv rehash
rbenv rehash

# Python maintenance
echo -e "${LG}[9/19] Updating Python packages${NC}"
pip install --upgrade pip setuptools wheel
pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
python -m pip check

# Node.js maintenance
echo -e "${LG}[10/19] Updating Node.js packages${NC}"
npm update -g
rm ~/.npm/_logs/*-debug.log #temporary
npm cache verify

# Ruby maintenance
echo -e "${LG}[11/19] Updating Ruby gems${NC}"
gem update --system
gem update
gem cleanup
bundle-audit update

# PHP maintenance
echo -e "${LG}[12/19] Updating PHP packages${NC}"
pear clear-cache
pecl clear-cache
pear update-channels
pecl update-channels

# Go maintenance
echo -e "${LG}[13/19] Updating Go packages${NC}"
go clean

# Quick Look maintenance
echo -e "${LG}[14/19] Reloading Quick Look generators${NC}"
qlmanage -r
qlmanage -r cache

# MacOS system maintenance
echo -e "${LG}[15/19] Running MacOS maintenance routines${NC}"
sudo periodic daily weekly monthly

# MacOS system updates
echo -e "\n${LG}[16/19] Updating MacOS${NC}"
sudo softwareupdate -ia

# Backup dot and config files
echo -e "${LG}[17/19] Backing up dot and config files${NC}"
mackup backup -f

# Reset Launchpad
echo -e "${LG}[18/19] Resetting Launchpad${NC}"
defaults write com.apple.dock ResetLaunchPad -bool true
killall Dock

# Final checkups
echo -e "${LG}[19/19] Running final health checks${NC}"
brew doctor --verbose
