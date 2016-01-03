#!/bin/bash
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
sudo chown -R $(whoami):admin /usr/local

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
gem install brakeman
gem install bundler-audit
gem install calabash-android
gem install calabash-cucumber
gem install cocoapods
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

# Update gem packages for jruby
rvm use jruby
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
npm install -g generator-angular
npm install -g generator-karma
npm install -g generator-webapp
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
pip install virtualenv
pip install virtualenvwrapper
pip install Django
pip install numpy
pip install scipy
pip install matplotlib
pip install pandas
pip install sympy
pip install nose
pip install unittest2
pip install seaborn
pip install scikit-learn
pip install "ipython[all]"
pip install bokeh
pip install Flask
pip install sqlalchemy
pip install mysql-python
pip install boto
pip install awscli
pip install mrjob
pip install s3cmd
pip install Appium-Python-Client
pip install robotframework
pip install robotframework-appiumlibrary

# Update pip3 packages
pip3 install virtualenv
pip3 install virtualenvwrapper
pip3 install Django
pip3 install numpy
pip3 install scipy
pip3 install matplotlib
pip3 install pandas
pip3 install sympy
pip3 install nose
pip3 install unittest2
pip3 install seaborn
pip3 install scikit-learn
pip3 install "ipython[all]"
pip3 install bokeh
pip3 install Flask
pip3 install sqlalchemy
pip3 install mysqlclient
pip3 install boto
pip3 install awscli
pip3 install Appium-Python-Client

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
