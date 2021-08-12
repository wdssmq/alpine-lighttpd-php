```bash
cd /root/Git/alpine-lighttpd-php
docker build -t wdssmq/lighttpd-php .

# 部署容器
DIR_lighttpd='/home/www/lighttpd'
mkdir -p $DIR_lighttpd
cd ${DIR_lighttpd}
docker rm --force lighttpd-php
docker run --name lighttpd-php \
 --net=net_web \
 -p 8033:80 \
 -v $(pwd):/var/www \
 -d wdssmq/lighttpd-php

docker logs lighttpd-php

# 进入容器内部
docker exec -it lighttpd-php /bin/sh

php-cgi -m

# 复制文件
docker cp lighttpd-php:/etc/lighttpd "/root/Git/alpine-lighttpd-php/etc.out"
docker cp lighttpd-php:/etc/php7 "/root/Git/alpine-lighttpd-php/etc.out"

# docker cp  "/root/ssh-lighttpd/etc/php7/php.ini" lighttpd-php:/etc/php7/php.ini
docker restart lighttpd-php
```



```bash
## Download Z-BlogPHP
DIR_lighttpd='/home/www/lighttpd'
# mkdir -p $DIR_lighttpd
cd ${DIR_lighttpd}
ZC_INSTALL_NAME=Z-BlogPHP_1_7_0_2945_Tenet
if ! [ -e index.php ]; then
    echo Downloading Z-BlogPHP...
    wget https://update.zblogcn.com/zip/$ZC_INSTALL_NAME.tar.gz
    echo Unpacking Z-BlogPHP...
    tar -xf ./$ZC_INSTALL_NAME.tar.gz
    echo Delete zip
    rm $ZC_INSTALL_NAME.tar.gz
fi
```