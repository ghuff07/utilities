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

# python / pip packages
pip install bandit
pip install jupyter
pip install numpy
pip install pep8
pip install pyflakes
pip install pyyaml
pip install scipy
pip install virtualenv

# python3 / pip3 packages
pip3 install bandit
pip3 install jupyter
pip3 install numpy
pip3 install pep8
pip3 install pyflakes
pip3 install pyyaml
pip3 install scipy
pip3 install virtualenv

# node.js / npm packages
npm install -g bower
npm install -g coffee-script
npm install -g csslint
npm install -g eslint
npm install -g express
npm install -g generator-angular
npm install -g grunt-cli
npm install -g less
npm install -g license-checker
npm install -g nodemon
npm install -g nsp
npm install -g retire
npm install -g secscan
npm install -g snyk
npm install -g stylus
npm install -g yo

# ruby / gem packages
gem install brakeman
gem install bundler
gem install bundler-audit
gem install cane
gem install cocoapods
gem install compass
gem install consistency_fail
gem install cucumber
gem install dawnscanner -P MediumSecurity
gem install gauntlt
gem install github-linguist
gem install gitrob
gem install haml
gem install idb
gem install license_finder
gem install nokogiri
gem install rails
gem install rails-audit
gem install rails_best_practices
gem install rspec
gem install rubocop
gem install scss_lint
gem install selenium-webdriver
gem install tarantula

# php / pear packages
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear install --force --alldeps phpmd/PHP_PMD
pear install --force PHP_CodeSniffer

# golang / go packages
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update
