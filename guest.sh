#!/bin/sh

sudo yum install -y https://rpm.nodesource.com/pub_12.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm
sudo yum install -y git wget epel-release openssl-devel readline-devel zlib-devel gcc gcc-c++
sudo yum install -y nodejs --enablerepo=epel

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum -y install yarn

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv/plugins/ruby-build
sudo ./install.sh

rbenv install -l

# --------

rbenv install 2.7.2
rbenv rehash
rbenv global 2.7.2
ruby -v

gem install rails
rails -v

wget https://www.sqlite.org/2019/sqlite-autoconf-3300100.tar.gz
tar xvfz sqlite-autoconf-3300100.tar.gz
cd sqlite-autoconf-3300100
./configure --prefix=/usr/local
make
sudo make install
bundle config build.sqlite3 "--with-sqlite3-lib=/usr/local/lib"
cd ~

sudo systemctl stop firewalld.service
sudo systemctl mask firewalld.service
sudo systemctl list-unit-files | grep firewalld

rails new rails-test
ip addr show
cd rails-test/
rails s -b 0.0.0.0
