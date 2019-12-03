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

# File and folder ownership
echo -e "${LG}[1/24] Resetting file and folder ownership${NC}"
sudo chflags norestricted /usr/local && sudo chown -R $(whoami) $(brew --prefix)/* && sudo chown -R $(whoami):staff /Users/$(whoami)

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# App Store and Xcode maintenance
echo -e "${LG}[2/24] Updating App Store apps${NC}"
mas outdated
mas upgrade

echo -e "${LG}[3/24] Verifying Xcode Command Line Tools${NC}"
xcode-select --install

# Homebrew maintenance
echo -e "${LG}[4/24] Updating Homebrew${NC}"
cd "$(brew --prefix)/homebrew"
git fetch origin
git reset --hard origin/master
brew tap --repair

echo -e "${LG}[5/24] Updating Homebrew formulae${NC}"
brew update
brew upgrade

echo -e "${LG}[6/24] Updating Homebrew casks${NC}"
brew cu -a -y --cleanup

echo -e "${LG}[7/24] Recreating Homebrew Brewfile${NC}"
brew bundle dump -force

echo -e "${LG}[8/24] Cleaning up Homebrew${NC}"
brew cleanup -s
brew services cleanup

echo -e "${LG}[9/24] Relinking Homebrew formulae${NC}"
brew list -1 | xargs -I formula sh -c "brew unlink formula && brew link --overwrite formula"

# Python maintenance
echo -e "${LG}[10/24] Updating Python packages${NC}"
pip3 install --upgrade pip setuptools wheel
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U

# Node.js maintenance
echo -e "${LG}[11/24] Updating Node.js packages${NC}"
npm install -g npm@latest
npm cache verify
npm update -g

# Ruby maintenance
echo -e "${LG}[12/24] Updating RVM${NC}"
rvm get stable
rvm requirements

echo -e "${LG}[13/24] Updating system Ruby gems${NC}"
rvm use system
gem update --system
gem update
gem regenerate_binstubs
gem cleanup

echo -e "${LG}[14/24] Updating current Ruby gems${NC}"
rvm use default
rvm rubygems latest
rvm all do gem update --system
rvm all do gem update
rvm all do gem regenerate_binstubs
rvm all do gem cleanup

echo -e "${LG}[15/24] Cleaning up RVM${NC}"
rvm cleanup all
rvm repair all

echo -e "${LG}[16/24] Updating bundle-audit${NC}"
bundle-audit update

# PHP maintenance
echo -e "${LG}[17/24] Updating PHP packages${NC}"
pecl install xdebug
pear clear-cache
pecl clear-cache
pear update-channels
pecl update-channels

# Go maintenance
echo -e "${LG}[18/24] Updating Go packages${NC}"
go get -u all
go clean

# Quick Look maintenance
echo -e "${LG}[19/24] Reloading Quick Look generators${NC}"
qlmanage -r
qlmanage -r cache

# MacOS system maintenance
echo -e "${LG}[20/24] Running MacOS maintenance routines${NC}"
sudo periodic daily weekly monthly

# MacOS system updates
echo -e "\n${LG}[21/24] Updating MacOS${NC}"
sudo softwareupdate -ia

# Backup dot and config files
echo -e "${LG}[22/24] Backing up dot and config files${NC}"
mackup backup

# Reset Launchpad
echo -e "${LG}[23/24] Resetting Launchpad${NC}"
rm ~/Library/Application\ Support/Dock/*.db
rm -rf "$TMPDIR../0/com.apple.dock.launchpad/db"
defaults write com.apple.dock ResetLaunchPad -bool true
sudo killall -SIGKILL cfprefsd && killall Dock && killall Finder

# Final checkups
echo -e "${LG}[24/24] Running final health checks${NC}"
brew cask doctor
brew doctor
brew missing
