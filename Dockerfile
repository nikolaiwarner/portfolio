FROM alpine:3.3

MAINTAINER Nick Warner "nickwarner@gmail.com"

RUN apk update && apk add bash curl

WORKDIR /meteor

RUN curl -sS https://install.meteor.com | HOME=/meteor /bin/sh

EXPOSE 3000

ADD . /meteor




CMD ["HOME=/meteor", "meteor"]
