echo "JJ checkpoint file" > /var/jj-check.txt

echo "Install web server"
apt-get update
apt-get upgrade -y
apt-get -y install apache2