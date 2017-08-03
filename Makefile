NAME =			lemp
VERSION =		latest
VERSION_ALIASES =
TITLE =			LEMP
DESCRIPTION =		LEMP
SOURCE_URL =		https://github.com/scaleway-community/scaleway-lemp
DEFAULT_IMAGE_ARCH =	x86_64

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =
IMAGE_NAME =		LEMP - Nginx+PHP+MySQL

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
