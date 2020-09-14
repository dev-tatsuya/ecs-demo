FROM golang:1.13-alpine3.12 as builder

WORKDIR /go/src/app

ENV GO111MODULE=on \
    TZ=Asia/Tokyo

RUN addgroup -g 10001 -S myapp \
    && adduser -u 10001 -G myapp -S myapp

RUN apk add --no-cache \
        alpine-sdk \
        git

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/app main.go

FROM scratch

COPY --from=builder /go/bin/app /go/bin/app
COPY --from=builder /etc/group /etc/group
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 8080

USER myapp

ENTRYPOINT ["/go/bin/app"]
