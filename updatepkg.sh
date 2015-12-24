#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# Update gem packages from ruby
rvm use default
gem install appium_console
gem install brakeman
gem install bundler-audit
gem install calabash-android
gem install calabash-cucumber
gem install compass
gem install cucumber
gem install dawnscanner
gem install flaky
gem install gauntlt
gem install gitrob
gem install idb
gem install license_finder
gem install rails
gem install rails-audit
gem install rest-client
gem install rspec
gem install rspec-expectations
gem install rubocop
gem install ruby-advisory-db-check
gem install selenium-webdriver
gem install tarantula
gem install tlspretense
rvm use default

# Update gem packages from jruby
rvm use jruby-1.7.22
jruby -S gem install buby
jruby -S gem install nokogiri
jruby -S gem install savon
rvm use default

# Update npm packages
npm install -g angular
npm install -g appium
npm install -g bower
npm install -g coffee-script
npm install -g coffeelint
npm install -g cordova
npm install -g csslint
npm install -g david
npm install -g dragula
npm install -g express
npm install -g express-generator
npm install -g grunt
npm install -g grunt-cli
npm install -g gulp
npm install -g jshint
npm install -g less
npm install -g license-checker
npm install -g nodemon
npm install -g nsp
npm install -g phonegap
npm install -g retire
npm install -g secscan
npm install -g selenium-standalone
npm install -g wd
npm install -g yo

#Update pip packages
pip install Django

# Update go packages
go get -u github.com/nsf/gocode
go get -u github.com/mtesauro/jerry-curl
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update

# Update pear packages
sudo pear channel-discover pear.phpmd.org
sudo pear channel-discover pear.pdepend.org
sudo pear install --force --alldeps phpmd/PHP_PMD
sudo pear install --force PHP_CodeSniffer
sudo pear upgrade --force pear/Structures_Graph
sudo pear upgrade --force pear/XML_Util
sudo pear upgrade --force pear/Console_GetoptPlus
