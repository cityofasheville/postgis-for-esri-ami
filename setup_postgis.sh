#!/bin/bash

#update and make sure all postgis depencies are setup
#awesomes that postgres9.2 is arleady installed in this case with esri ami's
sudo apt-get -y update
sudo apt-get -y install wget
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
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

sudo -u postgres PGPASSWORD=postgres createdb template_postgis
sudo -u postgres PGPASSWORD=postgres createlang -U postgres plpgsql template_postgis
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "create extension postgis;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "create extension postgis_topology;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "create extension fuzzystrmatch;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "create extension pg_trgm;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "create extension hstore;"

#fixes error gist_geometry_ops dosen't exist
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -f /home/ubuntu/postgis-2.0.6/postgis/legacy_gist.sql

sudo service postgresql stop
sudo service postgresql start 
