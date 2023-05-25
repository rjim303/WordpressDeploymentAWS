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
