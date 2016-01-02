NAME = dayzleaper/docker-unifi
VERSION = 4.8.9

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build -t $(NAME):$(VERSION) .

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

run: build
	docker run -d --net=host -p 18080:18080 -p 18443:18443 -e HTTP_PORT=18080 -e HTTPS_PORT=18443 -v /share/CACHEDEV1_DATA/docker/unifi:/var/lib/unifi -v /etc/localtime:/etc/localtime:ro --name unifi $(NAME):$(VERSION)
