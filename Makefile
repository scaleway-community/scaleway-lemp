DOCKER_NAMESPACE =	armbuild/
NAME =			scw-app-lemp
VERSION =		latest
VERSION_ALIASES =
TITLE =			LEMP
DESCRIPTION =		LEMP
SOURCE_URL =		https://github.com/scaleway/image-app-lemp


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
## Here you can add custom commands and overrides
