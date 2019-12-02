#!/bin/bash

sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &
sudo chflags norestricted /usr/local && sudo chown -R $(whoami) $(brew --prefix)/* && sudo chown -R $(whoami):staff /Users/$(whoami)

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# homebrew packages
brew reinstall ack
brew reinstall ansible
brew reinstall autopep8
brew reinstall bash-completion@2
brew reinstall binutils
brew reinstall cassandra
brew reinstall coreutils
brew reinstall couchdb
brew reinstall dep
brew reinstall dependency-check
brew reinstall diffutils
brew reinstall ed
brew reinstall elasticsearch
brew reinstall emacs
brew reinstall file-formula
brew reinstall findutils
brew reinstall fzf
brew reinstall gawk
brew reinstall gdb # gdb requires further actions to make it work. See `brew info gdb`.
brew reinstall git
brew reinstall git-secrets
brew reinstall gnu-indent
brew reinstall gnu-sed
brew reinstall gnu-tar
brew reinstall gnu-which
brew reinstall gnupg
brew reinstall gnutls
brew reinstall go
brew reinstall golangci-lint
brew reinstall gpatch
brew reinstall gradle
brew reinstall grep
brew reinstall groovy
brew reinstall gzip
brew reinstall helm
brew reinstall httpd
brew reinstall jenkins
brew reinstall jupyterlab
brew reinstall kibana
brew reinstall kotlin
brew reinstall kubectl
brew reinstall less
brew reinstall logstash
brew reinstall m4
brew reinstall make
brew reinstall mas
brew reinstall matplotlib
brew reinstall maven
brew reinstall minikube
brew reinstall mongodb-community
brew reinstall mysql
brew reinstall nano
brew reinstall nmap
brew reinstall node
brew reinstall numpy
brew reinstall openssh
brew reinstall perl
brew reinstall php
brew reinstall postgresql
brew reinstall pylint
brew reinstall python
brew reinstall rabbitmq
brew reinstall redis
brew reinstall rsync
brew reinstall rustup-init
brew reinstall sbt
brew reinstall scala
brew reinstall scipy
brew reinstall screen
brew reinstall shellcheck
brew reinstall shfmt
brew reinstall sonar-scanner
brew reinstall sonarqube
brew reinstall speedtest-cli
brew reinstall ssllabs-scan
brew reinstall subversion
brew reinstall terraform
brew reinstall tomcat
brew reinstall tree
brew reinstall unzip
brew reinstall vim
brew reinstall watch
brew reinstall wdiff
brew reinstall wget
brew reinstall yarn
brew reinstall zsh

# python3 / pip3 packages
pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install --upgrade wheel
pip3 install pytest
pip3 install shodan
pip3 install tensorflow

# node.js / npm packages
npm install -g npm@latest
npm install -g eslint
npm install -g eslint-plugin-no-unsafe-innerhtml
npm install -g eslint-plugin-scanjs-rules

# ruby / gem packages
gem install bundler
gem install debase
gem install rails
gem install rails-audit
gem install rubocop
gem install ruby-debug-ide
gem install solargraph

# golang / go packages
go get github.com/ezekg/git-hound

# php / pecl packages
pecl install xdebug
