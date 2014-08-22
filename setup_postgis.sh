#!/bin/bash

#update and make sure all postgis depencies are setup
sudo apt-get -y update
sudo apt-get -y install wget
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> sudo /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y install postgresql-server-dev-9.2
sudo apt-get -y install postgresql-server-contrib-9.2
sudo apt-get -y install libproj0
sudo apt-get -y install build-essential
sudo apt-get -y install libxml2-dev
sudo apt-get -y install libproj-dev
sudo apt-get -y install libjson0-dev
sudo apt-get -y install libgdal1-dev
sudo apt-get -y install xsltproc
sudo apt-get -y install docbook-xsl
sudo apt-get -y install docbook-mathml

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


sudo service postgresql stop
sudo service postgresql start 

#spatially  enable default databases make sure that the user postgres is set to trust for local conections in the pg_hba.conf file
#then make sure you switch this to md5 after.
sudo -u postgres psql -U postgres -d postgres -c "create extension postgis;"
sudo -u postgres psql -U postgres -d postgres -c "create extension postgis_topology;"
sudo -u postgres psql -U postgres -d geodata -c "create extension postgis;"
sudo -u postgres psql -U postgres -d geodata -c "create extension postgis_topology;"
sudo -u postgres psql -U postgres -d egdb -c "create extension postgis;"
sudo -u postgres psql -U postgres -d egdb -c "create extension postgis_topology;"


sudo service postgresql stop
sudo service postgresql start 
