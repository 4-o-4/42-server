# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gplaid <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/06 11:48:16 by gplaid            #+#    #+#              #
#    Updated: 2021/01/06 11:48:24 by gplaid           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL maintainer="gplaid@student.21-school.ru"

RUN apt-get update && apt-get --yes install \
    mariadb-server \
    nginx \ 
    php-fpm \
    php-mbstring \
    php-mysql \
    wget

# Wordpress
RUN wget --quiet https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm -rf latest.tar.gz && \
    mv wordpress/ /var/www/wordpress

RUN cd /var/www/wordpress && \
    sed -e "s/database_name_here/wordpress/" \
        -e "s/username_here/gplaid/" \
        -e "s/password_here/iegah9Ah/" \
        wp-config-sample.php > wp-config.php

# phpMyAdmin
RUN wget --quiet https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
    tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz && \
    rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz && \
    mv phpMyAdmin-5.0.4-all-languages/ /usr/share/phpmyadmin && \
    mkdir -p /usr/share/phpmyadmin/tmp

RUN cd /usr/share/phpmyadmin && \
    sed "s/cfg\['blowfish_secret'\] = ''/cfg['blowfish_secret'] = 'oonie2teer5die7uowequi6AhZ1aezah'/" \
    *.inc.php > config.inc.php && \
    echo "\$cfg['TempDir'] = '/tmp';" >> config.inc.php

RUN ln -s /usr/share/phpmyadmin/ /var/www/

# MySQL
RUN service mysql start && \
    mysql -e "CREATE DATABASE wordpress; \
    GRANT ALL PRIVILEGES ON wordpress.* TO 'gplaid'@'localhost' IDENTIFIED BY 'iegah9Ah'; \
    FLUSH PRIVILEGES;"

# Nginx configuration
COPY ./srcs/wp-nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wp-nginx.conf /etc/nginx/sites-enabled/

# SSL
RUN openssl req -x509 -newkey rsa:2048 -nodes -sha256 \
    -keyout /etc/ssl/private/localhost.key \
    -out /etc/ssl/certs/localhost.crt \
    -subj "/CN=localhost"

EXPOSE 80 443

CMD service php7.3-fpm start && \
    service mysql start && \
    service nginx start && \
    bash
