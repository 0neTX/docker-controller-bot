FROM alpine:3

ENV TELEGRAM_THREAD=1
ENV CHECK_UPDATES=1
ENV CHECK_UPDATE_EVERY_HOURS=4
ENV CHECK_UPDATE_STOPPED_CONTAINERS=1
ENV BUTTON_COLUMNS=2
ENV LANGUAGE=ES
ENV EXTENDED_MESSAGES=0
ENV TZ=UTC

ARG VERSION=3.5.1

WORKDIR /app
RUN wget https://github.com/dgongut/docker-controller-bot/archive/refs/tags/v${VERSION}.tar.gz -P /tmp
RUN tar -xf /tmp/v${VERSION}.tar.gz
RUN mv docker-controller-bot-${VERSION}/* /app
RUN rm /tmp/v${VERSION}.tar.gz
RUN rm -rf docker-controller-bot-${VERSION}/
RUN apk add --no-cache python3 py3-pip tzdata
RUN export PIP_BREAK_SYSTEM_PACKAGES=1; pip3 install --no-cache-dir -Ur /app/requirements.txt

WORKDIR /app
COPY . .

ENTRYPOINT ["python3", "docker-controller-bot.py"]
