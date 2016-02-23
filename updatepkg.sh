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

# Update gem packages for ruby
rvm use default
gem install appium_console
gem install appium_lib
gem install arachni
gem install brakeman
gem install bundler-audit
gem install calabash-android
gem install calabash-cucumber
gem install capybara-webkit
gem install cocoapods
gem install compass
gem install cucumber
gem install dawnscanner
gem install flaky
gem install gauntlt
gem install gitrob
gem install idb
gem install jasmine
gem install license_finder
gem install nokogiri
gem install rails
gem install rails-audit
gem install rest-client
gem install rspec
gem install rspec-expectations
gem install rubocop
gem install rubocop-cask
gem install ruby-advisory-db-check
gem install savon
gem install selenium-webdriver
gem install tarantula
gem install therubyracer
gem install tlspretense
rvm use default

# Update gem packages for jruby
rvm use jruby
jruby -S gem install buby
jruby -S gem install nokogiri
jruby -S gem install savon
rvm use default

# Update npm packages
npm install -g angular
npm install -g appium
npm install -g appium-doctor
npm install -g babel
npm install -g babel-eslint
npm install -g bootlint
npm install -g bootstrap
npm install -g bower
npm install -g browserify
npm install -g chai
npm install -g coffee-script
npm install -g cordova
npm install -g csslint
npm install -g david
npm install -g dragula
npm install -g eslint
npm install -g eslint-plugin-angular
npm install -g eslint-plugin-react
npm install -g expect.js
npm install -g express
npm install -g express-generator
npm install -g forever
npm install -g generator-angular
npm install -g generator-karma
npm install -g generator-webapp
npm install -g grunt
npm install -g grunt-cli
npm install -g grunt-eslint
npm install -g gulp
npm install -g gulp-eslint
npm install -g jasmine
npm install -g jasmine-babel
npm install -g karma
npm install -g karma-eslint
npm install -g less
npm install -g license-checker
npm install -g mocha
npm install -g nodemon
npm install -g nsp
npm install -g phonegap
npm install -g pm2
npm install -g react
npm install -g request
npm install -g retire
npm install -g secscan
npm install -g selenium-standalone
npm install -g statsd
npm install -g wd
npm install -g webpack
npm install -g yo

# Update bower packages
bower install angular --force-latest
bower install bootstrap --force-latest
bower install bootstrap-material-design --force-latest
bower install bootstrap-sass --force-latest
bower install jasmine-core --force-latest
bower install jquery --force-latest
bower install jquery-mobile --force-latest
bower install jquery-ui --force-latest
bower install qunit --force-latest

# Update pip packages
pip install "ipython[all]"
pip install ansible
pip install Appium-Python-Client
pip install awscli
pip install bokeh
pip install boto
pip install capstone
pip install Django
pip install django-markdown
pip install Flask
pip install hg-git
pip install jasmine
pip install markdown
pip install matplotlib
pip install mrjob
pip install mysql-python
pip install nose
pip install numpy
pip install pandas
pip install pep8
pip install pyflakes
pip install pyyaml
pip install robotframework
pip install robotframework-appiumlibrary
pip install s3cmd
pip install scikit-learn
pip install scipy
pip install seaborn
pip install sqlalchemy
pip install sympy
pip install unittest2
pip install virtualenv
pip install virtualenvwrapper

# Update pip3 packages
pip3 install "ipython[all]"
pip3 install ansible
pip3 install Appium-Python-Client
pip3 install awscli
pip3 install bokeh
pip3 install boto
pip3 install capstone
pip3 install Django
pip3 install django-markdown
pip3 install Flask
pip3 install hg-git
pip3 install jasmine
pip3 install markdown
pip3 install matplotlib
pip3 install mysqlclient
pip3 install nose
pip3 install numpy
pip3 install pandas
pip3 install pep8
pip3 install pyflakes
pip3 install pyyaml
pip3 install scikit-learn
pip3 install scipy
pip3 install seaborn
pip3 install sqlalchemy
pip3 install sympy
pip3 install unittest2
pip3 install virtualenv
pip3 install virtualenvwrapper

# Update go packages
go get -u github.com/mtesauro/jerry-curl
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update

# Update pear packages
source $(brew --prefix php-version)/php-version.sh && php-version 5
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear upgrade --force --alldeps pear/Console_GetoptPlus
pear upgrade --force --alldeps pear/PHP_CodeSniffer
pear upgrade --force --alldeps pear/Structures_Graph
pear upgrade --force --alldeps pear/XML_Util

source $(brew --prefix php-version)/php-version.sh && php-version 7
pear channel-discover pear.phpmd.org
pear channel-discover pear.pdepend.org
pear upgrade --force --alldeps pear/Console_GetoptPlus
pear upgrade --force --alldeps pear/PHP_CodeSniffer
pear upgrade --force --alldeps pear/Structures_Graph
pear upgrade --force --alldeps pear/XML_Util
