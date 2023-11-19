VERSION: $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
format:
	go fmt ./
build:
	go build -v -o rexbot -ldflags "-X="github.com/rexsplode/rexbot/cmd.version=${VERSION}
