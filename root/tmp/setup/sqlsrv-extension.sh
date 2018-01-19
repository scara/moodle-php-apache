#!/usr/bin/env bash

set -e

# Install Microsoft dependencies for sqlsrv
# Debian 9 requires ODBC driver 17, still not package available in repos, so followed this
# https://github.com/Microsoft/msphpsql/wiki/Install-and-configuration#user-content-odbc-17-linux-installation
echo "Downloading sqlsrv files"
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/8/prod.list -o /etc/apt/sources.list.d/mssql-release.list
apt-get update

echo "Install msodbcsql"
ACCEPT_EULA=Y apt-get install -y msodbcsql

# now remove ODBC driver 13.1, then download and install 17 from Github
apt-get purge -y msodbcsql

curl https://raw.githubusercontent.com/Microsoft/msphpsql/dev/ODBC%2017%20binaries%20preview/Debian%209/msodbcsql_17.0.0.5-1_amd64.deb \
    -o /tmp/msodbcsql_17.0.0.5-1_amd64.deb
curl https://raw.githubusercontent.com/Microsoft/msphpsql/dev/ODBC%2017%20binaries%20preview/Debian%209/mssql-tools_17.0.0.5-1_amd64.deb \
    -o /tmp/mssql-tools_17.0.0.5-1_amd64.deb

ACCEPT_EULA=Y dpkg -i /tmp/msodbcsql_17.0.0.5-1_amd64.deb
ACCEPT_EULA=Y dpkg -i /tmp/mssql-tools_17.0.0.5-1_amd64.deb

rm /tmp/msodbcsql_17.0.0.5-1_amd64.deb
rm /tmp/mssql-tools_17.0.0.5-1_amd64.deb

ln -fsv /opt/mssql-tools/bin/* /usr/bin

pecl install sqlsrv-5.2.0RC1
docker-php-ext-enable sqlsrv
