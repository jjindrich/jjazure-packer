echo "JJ checkpoint file" > /var/jj-check.txt

echo "JJ Install web server"
apt-get update
apt-get upgrade -y
apt-get -y install apache2

echo "JJ config web server"
cp app/index.html /var/www/html/index.html