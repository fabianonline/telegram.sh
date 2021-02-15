FROM alpine

WORKDIR /

RUN apk add --no-cache bash curl

COPY telegram /bin/telegram

