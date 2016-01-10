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

rvm use ruby-2.1.7@metasploit-framework
/usr/local/share/metasploit-framework/msfupdate
rvm use default
