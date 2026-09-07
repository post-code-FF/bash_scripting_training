#!/bin/bash

path="/var/www/app/deploy_tmp/"
version="7.146.17"
link="https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/$version/jfrog-artifactory-oss-$version-linux.tar.gz?_gl=1*nnn3el*_gcl_au*MTg3MDM4MDM5Mi4xNzgyMjk2NzU5*FPAU*MTg3MDM4MDM5Mi4xNzgyMjk2NzU5*_ga*MzkwNjU3ODQyLjE3NzEyNTM3MzQ.*_ga_SQ1NR9VTFJ*czE3ODIyOTY3NTkkbzQkZzEkdDE3ODIyOTcwMDkkajEzJGwwJGgyMjU2MjcwNzA.*_fplc*RnZQUzRpMiUyQldrNDI5MklQUVd6U3JHSFI2blJFV2R3dWMwRCUyQkx0YkhkU2lRZVJ5NkQ0SFNGNVQ2b2MlMkI1aU5iaUFvNVhvTmJ3OVduTzdlWVdQN3NaaXZzNlpvY09qaWZhN0RiQTIlMkYlMkJBVjJtdCUyRmpnQiUyRkZpR1dLJTJCVVJlNXRmQSUzRCUzRA.."

set -e
set -o pipefail

trap "rm -rf $path* ; rm -f artifactory.tar.gz ; echo 'Деплой провален! Производится откат...' " SIGINT SIGTERM

mkdir -p $path
echo "Скачивание пакета..."
curl -Lo artifactory.tar.gz $link  > /dev/null 2>&1
echo "Распаковка архива..."
tar -xzvf artifactory.tar.gz -C $path > /dev/null 2>&1 
if [ ! -f /etc/systemd/system/artifactory.service ]; then
    rm -f /etc/systemd/system/artifactory.service 
    cat <<EOF > /etc/systemd/system/artifactory.service
[Unit]
Description=Artifactory Mock Service for Testing

[Service]
Type=simple
ExecStart=/var/www/app/deploy_tmp/artifactory-oss-7.146.17/app/bin/artifactory.sh start

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
fi

systemctl restart artifactory.service 
echo "Деплой выполнен успешно!"