# syntax=docker/dockerfile:1.6

ARG DEBIAN_VERSION=bookworm-slim

## PHP-CLI image
FROM debian:${DEBIAN_VERSION} as php-cli

ARG PHP_VERSION=8.2
ARG DEBIAN_FRONTEND=noninteractive

ENV CONFIG_TARGET=cli \
	APP_DIR=/app \
	PHP_VERSION=${PHP_VERSION} \
	\
	MEMORY_LIMIT=-1 \
	MAX_EXECUTION_TIME=30 \
	POST_MAX_SIZE=256M \
	UPLOAD_MAX_FILESIZE=256M \
	\
	OPCACHE_ENABLE=1 \
	OPCACHE_ENABLE_CLI=0 \
	OPCACHE_MEMORY_CONSUMPTION=128M \
	OPCACHE_INTERNED_STRINGS_BUFFER=16 \
	OPCACHE_JIT=off \
	OPCACHE_JIT_BUFFER_SIZE=32M

RUN apt update && \
	apt install --no-install-recommends -yq \
		gettext-base \
		lsb-release \
		wget \
		ca-certificates  \
		unzip \
		zip && \
	wget https://packages.sury.org/php/apt.gpg -O /usr/share/keyrings/deb.sury.org-php.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php-sury.list && \
	apt update && \
	apt install --no-install-recommends -yq \
		php${PHP_VERSION}-cli \
		php${PHP_VERSION}-bcmath \
		php${PHP_VERSION}-curl \
		php${PHP_VERSION}-dom \
		php${PHP_VERSION}-intl \
		php${PHP_VERSION}-mbstring \
		php${PHP_VERSION}-zip \
		php${PHP_VERSION}-xml && \
	wget https://getcomposer.org/installer -O composer-setup.php && \
	php composer-setup.php && \
	rm composer-setup.php && \
	mv composer.phar /usr/bin/composer

# https://github.com/php/php-src/blob/17baa87faddc2550def3ae7314236826bc1b1398/sapi/fpm/php-fpm.8.in#L163
STOPSIGNAL SIGQUIT

COPY --link ./etc/php /etc/php
COPY --link --chmod=755 ./docker-entrypoint.d-cli /docker-entrypoint.d
COPY --link --chmod=755 ./docker-entrypoint /docker-entrypoint

WORKDIR ${APP_DIR}

ENTRYPOINT [ "/docker-entrypoint" ]

CMD [ "php", "-a" ]

## PHP-FPM image
FROM php-cli as php-fpm

ENV CONFIG_TARGET=fpm \
	MEMORY_LIMIT=128M \
	\
	FPM_LISTEN_PORT=9000 \
	FPM_LOG_LEVEL=notice \
	FPM_PM_MAX_CHILDREN=90 \
	FPM_PM_START_SERVERS=10 \
	FPM_PM_MIN_SPARE_SERVERS=4 \
	FPM_PM_MAX_SPARE_SERVERS=16 \
	FPM_PM_MAX_REQUEST=0

RUN apt --no-install-recommends install -yq \
	php${PHP_VERSION}-fpm && \
	ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/bin/php-fpm

COPY --link --chmod=755 ./docker-entrypoint.d-fpm /docker-entrypoint.d

EXPOSE ${FPM_LISTEN_PORT}

CMD [ "/usr/bin/php-fpm" ]
