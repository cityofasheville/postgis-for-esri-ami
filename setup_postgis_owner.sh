#!/bin/bash

#adds ownere schema for adding data to new sde/postgis db
sudo service postgresql stop
sudo service postgresql start 

sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "CREATE ROLE gisowner WITH PASSWORD 'gisowner' LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "CREATE SCHEMA gisowner AUTHORIZATION gisowner;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA gisowner TO sde;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA gisowner TO public;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA gisowner to postgres;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON DATABASE coagis to gisowner;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA sde to gisowner;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA public to gisowner;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "GRANT ALL ON SCHEMA topology to gisowner;"

sudo service postgresql stop
sudo service postgresql start 
