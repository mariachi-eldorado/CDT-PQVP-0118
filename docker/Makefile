VERSION_FILE=../VERSION
XWIKIURL="http://download.forge.ow2.org/xwiki/xwiki-10.0.war"

ifeq ($(strip $(NO_REV)),)
	DIRTY=$(shell git diff-index --quiet HEAD || echo "-dirty")
	REV=$(shell git rev-parse --short HEAD)$(DIRTY)
endif

ifeq ($(BUILD_VERSION),)
	VERSION=$(shell cat $(VERSION_FILE))
	ifeq ($(strip $(REV)),)
		BUILD_VERSION=$(VERSION)
	else
		BUILD_VERSION=$(VERSION)-$(REV)
	endif
endif

IMAGE_FILE=Dockerfile
IMAGE_DIR=.
IMAGE_NAME?=docker.jw4.us/cdt
ifeq ($(IMAGE_VERSIONED_NAME),)
	IMAGE_VERSIONED_NAME=$(IMAGE_NAME):$(BUILD_VERSION)
endif

PWD="$(shell cd ..; pwd -P)/"

all: build

build:
	@echo 'docker build'

clean:
	@echo 'clean'
	-rm -rf ./swagger ./xwiki-10.0 2> /dev/null

swagger:
	@echo 'copy swagger'

xwiki-10.0.war:
	wget $(XWIKIURL)

xwiki-10.0: xwiki-10.0.war
	 unzip -d xwiki-10.0 xwiki-10.0.war

xwiki: xwiki-10.0
	@echo 'copy xwiki'

image: swagger xwiki
	@echo 'docker image build'
	docker build -t $(IMAGE_VERSIONED_NAME) -t $(IMAGE_NAME):latest -f $(IMAGE_FILE) $(IMAGE_DIR)

push: image
	docker push $(IMAGE_VERSIONED_NAME)
	docker push $(IMAGE_NAME):latest

deploy:
	@echo 'deploy'


.PHONY: all build clean image push deploy
