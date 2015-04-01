## -*- docker-image-name: "armbuild/ocs-app-lemp:latest" -*-
FROM armbuild/ocs-distrib-ubuntu:trusty
MAINTAINER Online Labs <opensource@ocs.online.net> (@online_en)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get -q update				\
 && apt-get -y -qq upgrade   			\
 && apt-get -y -qq install    			\
    emacs vim					\
    git mercurial subversion			\
    nginx-full            			\
    php5-cgi php5-cli php5-fpm 			\
    php5-gd php-apc php-pear php5-common 	\
    php5-curl php5-mcrypt php5-memcached	\
    php5-sqlite 	  			\
    memcached	      	       			\
 && apt-get clean


# Enable extensions
RUN php5enmod apc \
    apcu \
    curl \
    gd \
    json \
    mcrypt \
    memcached \
    mysqli \
    mysql \
    opcache \
    pdo \
    pdo_mysql \
    pdo_sqlite \
    readline \
    sqlite3


# Extra deps
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer


# Patches
ADD patches/etc/ /etc/
ADD patches/usr/ /usr/
ADD patches/root/ /root/


# Dummy website
RUN mkdir -p /var/www/my_website/phpmyadmin \
    && echo 'Your server is being configured, refresh this page in a few seconds...' > /var/www/my_website/index.php \
    && cp /var/www/my_website/index.php /var/www/my_website/phpmyadmin/index.php \
    && ln -s /etc/nginx/sites-available/my_website /etc/nginx/sites-enabled/my_website \
    && rm -f /etc/nginx/sites-enabled/default


# Enable services
RUN update-rc.d php5-fpm enable
RUN update-rc.d nginx enable
RUN update-rc.d memcached enable


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
