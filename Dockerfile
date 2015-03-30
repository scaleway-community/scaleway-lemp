## -*- docker-image-name: "armbuild/ocs-app-lemp:latest" -*-
FROM armbuild/ocs-distrib-ubuntu:trusty
MAINTAINER Online Labs <opensource@ocs.online.net> (@online_en)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get -q update		\
 && apt-get -y -qq upgrade   	\
 && apt-get -y -qq install    	\
    emacs vim			\
    git mercurial subversion	\
    nginx-full            	\
    mysql-server          	\
    php5-fpm              	\
 && apt-get clean


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
