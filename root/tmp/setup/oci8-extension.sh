#!/usr/bin/env bash

set -e

echo "Downloading oracle files"

curl https://raw.githubusercontent.com/bumpx/oracle-instantclient/6aa46afa7a/instantclient-basic-linux.x64-12.2.0.1.0.zip \
    -o /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip
unzip /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/
rm /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip

curl https://raw.githubusercontent.com/bumpx/oracle-instantclient/6aa46afa7a/instantclient-sdk-linux.x64-12.2.0.1.0.zip \
    -o /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip
unzip /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/
rm /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip

curl https://raw.githubusercontent.com/bumpx/oracle-instantclient/6aa46afa7a/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip \
    -o /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip
unzip /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /usr/local/
rm /tmp/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

ln -s /usr/local/instantclient_12_2 /usr/local/instantclient
ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so
ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

#echo 'export LD_LIBRARY_PATH="/usr/local/instantclient"' >> /root/.bashrc
#echo 'umask 002' >> /root/.bashrc

echo 'instantclient,/usr/local/instantclient' | pecl install oci8 && docker-php-ext-enable oci8
echo 'oci8.statement_cache_size = 0' >> /usr/local/etc/php/conf.d/docker-php-ext-oci8.ini
