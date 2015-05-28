#!/bin/bash -v
# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

rvm use ruby-2.1.5@metasploit-framework
/usr/local/share/metasploit-framework/msfupdate
rvm use default
