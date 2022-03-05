FROM alpine:3.9 AS build

#Hugo version
ARG VERSION=0.92.2

ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz

RUN tar -zxvf hugo.tar.gz
RUN /hugo version

RUN apk add --no-cache git

COPY . /app
WORKDIR /app

RUN /hugo --minify --enableGitInfo

FROM docker.io/caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /app/public /web
