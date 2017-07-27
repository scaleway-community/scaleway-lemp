## -*- docker-image-name: "scaleway/lemp:xenial" -*-
FROM scaleway/ubuntu:amd64-xenial
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-xenial    # arch=armv7l
#FROM scaleway/ubuntu:arm64-xenial    # arch=arm64
#FROM scaleway/ubuntu:i386-xenial     # arch=i386
#FROM scaleway/ubuntu:mips-xenial     # arch=mips


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Install packages
RUN apt-get -q update				\
 && apt-get -y -qq upgrade   			\
 && apt-get -y -qq install    			\
    emacs vim					\
    git mercurial subversion			\
    nginx-full            			\
    php-cgi php-cli php-fpm 			\
    php-gd php-pear php-apcu			\
    php-curl php-mcrypt php-memcached		\
    php-sqlite3 php-mysql			\
    mysql-server				\
    memcached					\
 && apt-get clean


# Enable extensions
RUN phpenmod  apcu \
    curl \
    gd \
    json \
    mcrypt \
    memcached \
    mysqli \
    mysqlnd \
    pdo_mysql \
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
COPY ./overlay /


# Dummy website
RUN mkdir -p /var/www/my_website/phpmyadmin \
    && echo 'Your server is being configured, refresh this page in a few seconds...' > /var/www/my_website/index.php \
    && cp /var/www/my_website/index.php /var/www/my_website/phpmyadmin/index.php \
    && ln -s /etc/nginx/sites-available/my_website /etc/nginx/sites-enabled/my_website \
    && rm -f /etc/nginx/sites-enabled/default


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
