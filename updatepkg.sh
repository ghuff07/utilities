#!/bin/bash -v
# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# Update gem packages from ruby
rvm use default
gem install brakeman
gem install bundler-audit
gem install compass
gem install dawnscanner
gem install gitrob
gem install rails
gem install rubocop
gem install ruby-advisory-db-check

# Update gem packages from ruby 2.1.5
rvm use ruby-2.1.5
gem install idb
rvm use default

# Update gem packages from jruby
rvm use jruby-1.7.19
jruby -S gem install buby
jruby -S gem install nokogiri
jruby -S gem install savon
rvm use default

# Update npm packages
npm install -g angular
npm install -g bower
npm install -g coffee-script
npm install -g coffeelint
npm install -g cordova
npm install -g csslint
npm install -g david
npm install -g express
npm install -g grunt-cli
npm install -g gulp
npm install -g jshint
npm install -g less
npm install -g nodemon
npm install -g nsp
npm install -g phonegap
npm install -g retire
npm install -g mozilla/scanjs
npm install -g yo

# Update pear packages
sudo pear channel-discover pear.phpmd.org
sudo pear channel-discover pear.pdepend.org
sudo pear install --alldeps phpmd/PHP_PMD
sudo pear install PHP_CodeSniffer

# Update go packages
go get -u github.com/nsf/gocode
go get -u github.com/mtesauro/jerry-curl