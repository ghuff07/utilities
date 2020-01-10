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

# Homebrew formulas
echo -e "${LG}[1/6] Installing Homebrew formulae${NC}"
brew reinstall ack
brew reinstall ansible
brew reinstall autopep8
brew reinstall aws/tap/aws-sam-cli
brew reinstall awscli
brew reinstall bash-completion@2
brew reinstall binutils
brew reinstall coreutils
brew reinstall dependency-check
brew reinstall diffutils
brew reinstall dnsmasq
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
brew reinstall golangci/tap/golangci-lint
brew reinstall gpatch
brew reinstall gradle
brew reinstall graphviz
brew reinstall grep
brew reinstall groovy
brew reinstall gzip
brew reinstall helm
brew reinstall httpd
brew reinstall jenkins
brew reinstall jupyterlab
brew reinstall kibana
brew reinstall kotlin
brew reinstall kubernetes-cli
brew reinstall less
brew reinstall logstash
brew reinstall luarocks
brew reinstall m4
brew reinstall mackup
brew reinstall make
brew reinstall mas
brew reinstall brewsci/bio/matplotlib
brew reinstall maven
brew reinstall minikube
brew reinstall mongodb/brew/mongodb-community
brew reinstall mysql
brew reinstall nano
brew reinstall nginx
brew reinstall nmap
brew reinstall numpy
brew reinstall openssh
brew reinstall perl
brew reinstall php
brew reinstall postgresql
brew reinstall pyenv
brew reinstall pyenv-virtualenv
brew reinstall pylint
brew reinstall rbenv
brew reinstall redis
brew reinstall rsync
brew reinstall rustup-init
brew reinstall sbt
brew reinstall scala
brew reinstall scipy
brew reinstall screen
brew reinstall shellcheck
brew reinstall shfmt
brew reinstall skaffold
brew reinstall sonar-scanner
brew reinstall sonarqube
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

# python / pip packages
echo -e "${LG}[2/6] Installing Python packages${NC}"
pip install --upgrade pip
pip install --upgrade setuptools
pip install pytest

# node.js / npm packages
echo -e "${LG}[3/6] Installing Node.js packages${NC}"
nvm install-latest-npm
npm install -g eslint
npm install -g eslint-plugin-no-unsafe-innerhtml
npm install -g eslint-plugin-scanjs-rules

# ruby / gem packages
echo -e "${LG}[4/6] Installing Ruby gems${NC}"
gem install debase
gem install rails
gem install rails-audit
gem install rubocop
gem install ruby-debug-ide
gem install solargraph

# golang / go packages
echo -e "${LG}[5/6] Installing Go packages${NC}"
go get github.com/ezekg/git-hound

# php / pecl packages
echo -e "${LG}[6/6] Installing PHP packages${NC}"
pecl install xdebug
