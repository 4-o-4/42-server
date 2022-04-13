# server

<img src="https://www.docker.com/wp-content/uploads/2022/03/horizontal-logo-monochromatic-white.png" alt="Docker logo" height="70" />

#### Build image
```docker
docker build --tag wp .
```

#### Run container
```docker
docker run --name ft_server -it -p 80:80 -p 443:443 wp
```

#### Autoindex on/off
```bash
sed -i "s/\bon\b/off/" /etc/nginx/sites-available/wp-nginx.conf
service nginx reload
```
<!-- #### # Clear
```docker
docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
``` -->

#### Ressources
- [How To Install Linux, Nginx, MariaDB, PHP (LEMP stack) on Debian 10](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10)
- [How to install WordPress on Debian 10?](https://www.osradar.com/install-wordpress-debian-10/)
- [How To Install phpMyAdmin From Source on Debian 10](https://www.digitalocean.com/community/tutorials/how-to-install-phpmyadmin-from-source-debian-10)
- [Creating a Self-Signed SSL Certificate](https://linuxize.com/post/creating-a-self-signed-ssl-certificate/)
