
APP = $(shell basename $(shell git remote get-url origin))
TARGETOS = linux
REGISTRY = rexsplode
TARGETARCH = amd64
DEFAULT_VERSION := v0.0.0
VERSION ?= $(shell git describe --tags --abbrev=0 || echo "$(DEFAULT_VERSION)")-$(shell git rev-parse --short HEAD)

lint:
	golint
test:
	go test -v

format:
	go fmt ./

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

build: format
	GO_ENABLED=0 GOARCH=${TARGETARCH} GOOS=${TARGETOS} go build -v -o rexbot -ldflags "-X="github.com/rexsplode/rexbot/cmd.version=${VERSION}

clean:
	rm -rf rexbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
