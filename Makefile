TARGETOS = linux
DEFAULT_VERSION := v0.0.0
VERSION ?= $(shell git describe --tags --abbrev=0 || echo "$(DEFAULT_VERSION)")-$(shell git rev-parse --short HEAD)

lint:
	golint
test:
	go test -v

format:
	go fmt ./
build: format
	GO_ENABLED=0 GOARCH=${shell dpkg --print-architecture} GOOS=${TARGETOS} go build -v -o rexbot -ldflags "-X="github.com/rexsplode/rexbot/cmd.version=${VERSION}

clean:
	rm -rf rexbot
