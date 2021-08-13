### 构建并使用

```bash
# 构建镜像
cd /root/Git/alpine-lighttpd-php
docker build -t wdssmq/lighttpd-php .

# 部署容器
DIR_lighttpd='/home/www/lighttpd'
PORT_lighttpd=8033
mkdir -p $DIR_lighttpd
cd ${DIR_lighttpd}
docker rm --force lighttpd-php
docker run --name lighttpd-php \
 --net=net_web \
 -p ${PORT_lighttpd}:80 \
 -v $(pwd):/var/www \
 -d wdssmq/lighttpd-php
# 「调试」查看日志
docker logs lighttpd-php

# 「调试」进入容器内部
docker exec -it lighttpd-php /bin/sh

# 「在容器内」查看 PHP 模块
php-cgi -m

# 「调试」复制文件
docker cp lighttpd-php:/etc/lighttpd "/root/Git/alpine-lighttpd-php/etc.out"
docker cp lighttpd-php:/etc/php7 "/root/Git/alpine-lighttpd-php/etc.out"

# docker cp "/root/ssh-lighttpd/etc/php7/php.ini" lighttpd-php:/etc/php7/php.ini
docker restart lighttpd-php
```

### 下载 Z-BlogPHP

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
    echo Delete $ZC_INSTALL_NAME.tar.gz
    rm $ZC_INSTALL_NAME.tar.gz
fi
```