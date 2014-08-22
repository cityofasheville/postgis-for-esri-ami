#load postgres 9.2 the esri ami has this already only have it for testing script.
#also for loading postgres 9.2 for other installs
cd /etc/apt/sources.list.d/
sudo touch pdgd.list
#sudo chmod 777 pdgd.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >>  sudo -u root pdgd.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-9.2
