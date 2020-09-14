FROM golang:1.13-alpine3.12

RUN apk --update add --no-cache git && \
    go get -u github.com/oxequa/realize

ENV GO111MODULE=on \
    TZ=Asia/Tokyo

WORKDIR /go/src/ecs-demo
COPY . /go/src/ecs-demo

CMD ["realize", "start", "--name=api"]

EXPOSE 8080
