#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
sudo chflags norestricted /usr/local && sudo chown -R $(whoami):admin /usr/local && sudo chown -R $(whoami):staff /Users/$(whoami)

#for c in `brew cask list`; do ! brew cask info $c || brew cask install --force $c; done
brew cask list | xargs brew cask install --force
