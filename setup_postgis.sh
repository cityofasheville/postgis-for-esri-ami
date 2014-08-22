#!/bin/bash

apt-get -y update
apt-get -y install wget
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list
apt-get -y update
apt-get -y install postgresql-server-dev-9.2
apt-get -y install postgresql-server-contrib-9.2
apt-get -y install libproj0
apt-get -y install build-essential
apt-get -y install libxml2-dev
apt-get -y install libproj-dev
apt-get -y install libjson0-dev
apt-get -y install libgdal1-dev
cd ~
wget http://download.osgeo.org/geos/geos-3.3.9.tar.bz2
tar xfj geos-3.3.9.tar.bz2
cd geos-3.3.9
./configure
make
sudo make install
cd ..

wget http://download.osgeo.org/postgis/source/postgis-2.0.6.tar.gz
tar xfz postgis-2.0.6.tar.gz
cd postgis-2.0.6

./configure
make
sudo make install
sudo ldconfig
sudo make comments-install
