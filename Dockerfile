FROM alpine:3.9 AS build

#Hugo version
ARG VERSION=0.88.1

ADD https://github.com/gohugoio/hugo/releases/tag/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz

RUN tar -zxvf hugo.tar.gz
RUN /hugo version

RUN apk add --no-cache git

COPY . /app
WORKDIR /app

FROM docker.io/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/public /web
