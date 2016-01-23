#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
sudo chflags norestricted /usr/local && sudo chown -R $(whoami):admin /usr/local && sudo chown -R $(whoami):staff /Users/$(whoami)

for c in `brew list`; do ! brew info $c | grep "Required: " | sed -E 's/^.{9}//' | tr "," "\n" | xargs brew install; done
for c in `brew list`; do ! brew info $c | grep "Build: " | sed -E 's/^.{6}//' | tr "," "\n" | xargs brew install; done
for c in `brew list`; do ! brew info $c | grep "Optional: " | sed -E 's/^.{9}//' | tr "," "\n" | xargs brew install; done
for c in `brew list`; do ! brew info $c | grep "Recommended: " | sed -E 's/^.{12}//' | tr "," "\n" | xargs brew install; done
brew list | xargs brew reinstall
