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
pip2 install ansible
pip2 install autopep8
pip2 install bandit
pip2 install Django
pip2 install flake8
pip2 install Flask
pip2 install ipaddress
pip2 install ipwhois
pip2 install jupyter
pip2 install nose
pip2 install numpy
pip2 install pep8
pip2 install pyersinia
pip2 install pyflakes
pip2 install pylint
pip2 install pytest
pip2 install pyyaml
pip2 install scipy
pip2 install shodan
pip2 install speedtest-cli
pip2 install virtualenv
pip2 install yapf

# python3 / pip3 packages
pip3 install ansible
pip3 install autopep8
pip3 install bandit
pip3 install Django
pip3 install flake8
pip3 install Flask
pip3 install ipaddress
pip3 install ipwhois
pip3 install jupyter
pip3 install mypy-lang
pip3 install nose
pip3 install numpy
pip3 install pep8
pip3 install pyflakes
pip3 install pylint
pip3 install pytest
pip3 install pythonwhois
pip3 install pyyaml
pip3 install scipy
pip3 install shodan
pip3 install speedtest-cli
pip3 install virtualenv
pip3 install yapf

# node.js / npm packages
npm install -g appium
npm install -g autoprefixer
npm install -g ava
npm install -g bower
npm install -g browserify
npm install -g coffee-script
npm install -g cordova
npm install -g create-react-app
npm install -g csslint
npm install -g eslint
npm install -g eslint-plugin-scanjs-rules
npm install -g eslint-plugin-no-unsafe-innerhtml
npm install -g express
npm install -g generator-angular
npm install -g generator-angular-fullstack
npm install -g generator-aspnet
npm install -g generator-express
npm install -g generator-jasmine
npm install -g generator-karma
npm install -g generator-mocha
npm install -g generator-react-webpack
npm install -g generator-webapp
npm install -g grunt-cli
npm install -g gulp
npm install -g gulp-cli
npm install -g htmlhint
npm install -g ios-deploy
npm install -g jasmine
npm install -g less
npm install -g license-checker
npm install -g markdownlint-cli
npm install -g mocha
npm install -g nodemon
npm install -g nsp
npm install -g postcss-cli
npm install -g prettier
npm install -g react-native-cli
npm install -g retire
npm install -g secscan
npm install -g snyk
npm install -g stylelint
npm install -g stylus
npm install -g ts-node
npm install -g tslint
npm install -g typescript
npm install -g xo
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
gem install dawnscanner
gem install debase
gem install debride
gem install fasterer
gem install fastri
gem install gauntlt
gem install github-linguist
gem install gitrob
gem install haml
#gem install idb
gem install license_finder
gem install nokogiri
gem install rails
gem install rails-audit
gem install rails_best_practices
gem install rcodetools
gem install reek
gem install rspec
gem install rubocop
gem install ruby-debug-ide
gem install ruby-lint
gem install scss_lint
gem install selenium-webdriver
gem install tarantula

# php / pear packages
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear install --force --alldeps phpmd/PHP_PMD
pear install --force PHP_CodeSniffer

# golang / go packages
go get -u github.com/golang/lint/golint
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update
