#load postgres 9.2
cd /etc/apt/sources.list.d/
sudo chmod 775 pdgd.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >>  pdgd.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-9.2
