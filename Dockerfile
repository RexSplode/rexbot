FROM golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN go get
RUN make build
RUN echo $(ls -1 /go/src/app/)

FROM ubuntu:latest
WORKDIR /
COPY --from=builder go/src/app/rexbot .
RUN chmod +x /rexbot
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Print the list of files in /
RUN echo $(ls -1 /)
RUN echo $(./rexbot --version)

ENTRYPOINT [ "./rexbot" ]