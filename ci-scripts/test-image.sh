#!/bin/sh

docker run ${IMAGE_TAG} -v | grep "${PHP_VERSION}"
docker run ${IMAGE_TAG} -m | grep "bcmath" &&
docker run ${IMAGE_TAG} -m | grep "calendar" &&
docker run ${IMAGE_TAG} -m | grep "Core" &&
docker run ${IMAGE_TAG} -m | grep "ctype" &&
docker run ${IMAGE_TAG} -m | grep "curl" &&
docker run ${IMAGE_TAG} -m | grep "date" &&
docker run ${IMAGE_TAG} -m | grep "dom" &&
docker run ${IMAGE_TAG} -m | grep "exif" &&
docker run ${IMAGE_TAG} -m | grep "FFI" &&
docker run ${IMAGE_TAG} -m | grep "fileinfo" &&
docker run ${IMAGE_TAG} -m | grep "gettext" &&
docker run ${IMAGE_TAG} -m | grep "hash" &&
docker run ${IMAGE_TAG} -m | grep "iconv" &&
docker run ${IMAGE_TAG} -m | grep "intl" &&
docker run ${IMAGE_TAG} -m | grep "json" &&
docker run ${IMAGE_TAG} -m | grep "libxml" &&
docker run ${IMAGE_TAG} -m | grep "mbstring" &&
docker run ${IMAGE_TAG} -m | grep "openssl" &&
docker run ${IMAGE_TAG} -m | grep "pcntl" &&
docker run ${IMAGE_TAG} -m | grep "pcre" &&
docker run ${IMAGE_TAG} -m | grep "PDO" &&
docker run ${IMAGE_TAG} -m | grep "Phar" &&
docker run ${IMAGE_TAG} -m | grep "posix" &&
docker run ${IMAGE_TAG} -m | grep "readline" &&
docker run ${IMAGE_TAG} -m | grep "Reflection" &&
docker run ${IMAGE_TAG} -m | grep "session" &&
docker run ${IMAGE_TAG} -m | grep "shmop" &&
docker run ${IMAGE_TAG} -m | grep "SimpleXML" &&
docker run ${IMAGE_TAG} -m | grep "sockets" &&
docker run ${IMAGE_TAG} -m | grep "sodium" &&
docker run ${IMAGE_TAG} -m | grep "SPL" &&
docker run ${IMAGE_TAG} -m | grep "standard" &&
docker run ${IMAGE_TAG} -m | grep "sysvmsg" &&
docker run ${IMAGE_TAG} -m | grep "sysvsem" &&
docker run ${IMAGE_TAG} -m | grep "sysvshm" &&
docker run ${IMAGE_TAG} -m | grep "tokenizer" &&
docker run ${IMAGE_TAG} -m | grep "xml" &&
docker run ${IMAGE_TAG} -m | grep "xmlreader" &&
docker run ${IMAGE_TAG} -m | grep "xmlwriter" &&
docker run ${IMAGE_TAG} -m | grep "xsl" &&
docker run ${IMAGE_TAG} -m | grep "Zend OPcache" &&
docker run ${IMAGE_TAG} -m | grep "zip" &&
docker run ${IMAGE_TAG} -m | grep "zlib" &&
docker run ${IMAGE_TAG} -a | grep "Interactive" &&
docker run ${IMAGE_TAG} composer -V | grep "Composer version" &&
docker run -e UPLOAD_MAX_FILESIZE=200M ${IMAGE_TAG} -r 'phpinfo();' | grep "upload_max_filesize => 200M" &&
docker run -e POST_MAX_SIZE=200M ${IMAGE_TAG} -r 'phpinfo();' | grep "post_max_size => 200M" &&
docker run -e OPCACHE_MEMORY_CONSUMPTION=200M ${IMAGE_TAG} -r 'phpinfo();' | grep "opcache.memory_consumption => 200M"
#if [${IMAGE_VERSION} == 'fpm']