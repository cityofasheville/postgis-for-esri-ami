#!/bin/bash

#update and make sure all postgis depencies are setup
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

#get configure, make, and install geos.
cd ~
wget http://download.osgeo.org/geos/geos-3.3.9.tar.bz2
tar xfj geos-3.3.9.tar.bz2
cd geos-3.3.9
./configure
sudo make -s
sudo make install -s

#get configure, make, and install postgis with raster and topology
cd ~
wget http://download.osgeo.org/postgis/source/postgis-2.0.6.tar.gz
tar xfz postgis-2.0.6.tar.gz
cd postgis-2.0.6
./configure
make -s 
sudo make install -s 
sudo ldconfig
sudo make comments-install -s 
sudo ldconfig

#open connections for all postgres 
echo "listen_addresses = '*'" >> /etc/postgresql/9.2/main/postgresql.conf

#set permissions for all connections
echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/9.2/main/pg_hba.conf
echo "local    all            postgres                                trust" >> /etc/postgresql/9.2/main/pg_hba.conf

service postgresql stop
service postgresql start 

#spatial enable default databases
postgres -c "psql postgres -d geodata -c \"create extension postgis;\""
postgres -c "psql postgres -d geodata -c \"create extension postgis_toplogy;\""
postgres -c "psql postgres -d geodata -c \"create extension hstore;\""
postgres -c "psql postgres -d egdb -c \"create extension postgis;\""
postgres -c "psql postgres -d egdb -c \"create extension postgis_toplogy;\""
postgres -c "psql postgres -d egdb -c \"create extension hstore;\""
