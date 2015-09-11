DOCKER_NAMESPACE =	armbuild/
NAME =			scw-app-lemp
VERSION =		latest
VERSION_ALIASES =
TITLE =			LEMP
DESCRIPTION =		LEMP
SOURCE_URL =		https://github.com/scaleway-community/scaleway-lemp

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		LEMP - Nginx+PHP+MySQL

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
