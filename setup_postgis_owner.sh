#!/bin/bash

#adds ownere schema for adding data to new sde/postgis db
sudo service postgresql stop
sudo service postgresql start 

sudo -u postgres PGPASSWORD=postgres psql -U postgres -d coagis -c "CREATE SCHEMA owner AUTHORIZATION owner;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "GRANT ALL ON SCHEMA owner TO sde;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "GRANT ALL ON SCHEMA owner TO public;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "GRANT ALL ON SCHEMA owner to postgres;"
sudo -u postgres PGPASSWORD=postgres psql -U postgres -d template_postgis -c "GRANT ALL ON DATABASE coagis to owner;""

sudo service postgresql stop
sudo service postgresql start 
