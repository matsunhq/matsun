# syntax = docker/dockerfile:1.0-experimental

FROM golang:1.12.9 as builder

WORKDIR /matsun-API

RUN --mount=type=bind,source=./,target=/matsun-API \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o /bin/main

FROM alpine:3.10.2

RUN apk add --no-cache ca-certificates

COPY --from=builder /bin/main /bin/main

CMD ["/bin/main"]
