NAME = dayzleaper/docker-unifi
VERSION = 5.3.1
HTTP_PORT = 18080
HTTPS_PORT = 18443

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

run:
	docker run -d \
		--net=host \
		-p $(HTTP_PORT):$(HTTP_PORT) \
		-p $(HTTPS_PORT):$(HTTPS_PORT) \
		-e HTTP_PORT=$(HTTP_PORT) \
		-e HTTPS_PORT=$(HTTPS_PORT) \
		-v /share/CACHEDEV1_DATA/docker/unifi:/var/lib/unifi \
		--name unifi \
		$(NAME):$(VERSION)
