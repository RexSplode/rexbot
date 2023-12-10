
APP = $(shell basename $(shell git remote get-url origin))
TARGETOS = linux
REGISTRY = ghcr.io
USERNAME = rexsplode
OS = linux
TARGETARCH = amd64
DEFAULT_VERSION := v1.0.0
VERSION ?= $(shell git describe --tags --abbrev=0 || echo "$(DEFAULT_VERSION)")-$(shell git rev-parse --short HEAD)

lint:
	golint
test:
	go test -v

format:
	go fmt ./

image:
	docker build . -t ${REGISTRY}/${USERNAME}/${APP}:${VERSION}-${OS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${USERNAME}/${APP}:${VERSION}-${OS}-${TARGETARCH}

build: format
	GO_ENABLED=0 GOARCH=${TARGETARCH} GOOS=${TARGETOS} go build -v -o rexbot -ldflags "-X="github.com/rexsplode/rexbot/cmd.version=${VERSION}

clean:
	rm -rf rexbot
	docker rmi ${REGISTRY}/${USERNAME}/${APP}:${VERSION}-${OS}-${TARGETARCH}
