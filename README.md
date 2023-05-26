## Instalar apache2
```bash
sudo dnf install httpd
sudo service httpd start
sudo systemctl enable httpd
```

## Instalar MySQLServer
```bash
sudo dnf install mariadb105-server
sudo service maridb start
sudo systemctl enable mariadb
```

## Instalar php
```bash
sudo dnf install php php-devel
```

## Crear archivo phpinfo
```bash
echo "<?php phpinfo();?>" | sudo tee /var/www/html/phpinfo.php &>/dev/null
```

## Instalamos otros paquetes necesarios para wordpress
```bash
sudo dnf install wget php-mysqlnd php-fpm php-mysqli php-json -y
```

## Nos bajamos el comprimido con el Wordpress, cambiamos los permisos del propietario y grupo
```bash
su ec2-user
cd /home/ec2-user
wget https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz
sudo chown ec2-user:ec2-user wordpress
```

## Editamos y reemplazamos los campos necesarios en el fichero wp-config.php
```bash
cp wordpress/wp-config-sample.php wordpress/wp-config.php
cd wordpress
sed -i 's/database_name_here/WordpressDatabase/' wp-config.php
sed -i 's/username_here/wordpressuser/' wp-config.php
sed -i 's/password_here/pass1234$/' wp-config.php
sed -i 's/localhost/rafadatabase.c5vgwa0ff0gx.us-east-1.rds.amazonaws.com/' wp-config.php
```

## Otras configuracion finales
```bash
cd /home/ec2-user
sudo cp -r wordpress/* /var/www/html/
sudo sed -i '156 s/None/All/' /etc/httpd/conf/httpd.conf      
sudo dnf install php-gd -y
sudo chown -R apache:apache /var/www
sudo chmod 2775 /var/www
sudo service httpd restart
```

## Configuración Base de Datos
```bash
sudo mysql -u rafawordpress -h ${WordpressDB.Endpoint.Address} -prafawordpress1234 -e "CREATE USER 'wordpressuser'@'%' IDENTIFIED BY 'pass1234$';"
sudo mysql -u rafawordpress -h ${WordpressDB.Endpoint.Address} -prafawordpress1234 -e "GRANT ALL PRIVILEGES ON WordpressDatabase.* TO 'wordpressuser'@'%';"
sudo mysql -u rafawordpress -h ${WordpressDB.Endpoint.Address}  -prafawordpress1234 -e "FLUSH PRIVILEGES;"
```

## Por último reiniciamos el servicio httpd
```bash
sudo service httpd restart 
```
