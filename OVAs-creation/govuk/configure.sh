sudo apt install -y curl gnupg ca-certificates lsb-release
echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt update
sudo apt install -y nginx
./gencert.sh
sudo cp -f *.conf /etc/nginx/conf.d/
cp -f ca.pem ~
cat server.crt ca.pem | sudo tee /etc/nginx/default.crt >/dev/null
sudo ln -s /etc/nginx/default.crt /etc/nginx/assets.crt
umask 077
sudo cp -f server.key /etc/nginx/default.key
sudo ln -s /etc/nginx/default.key /etc/nginx/assets.key
sudo mkdir -p /var/log/nginx/a/ /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo systemctl enable --now nginx
