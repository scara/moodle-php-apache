#!/usr/bin/env bash

set -e

# HACK Install solr directly from git since the latest source tarball from PECL, 2.4.0, is outdated (2016-03-30).
# Ref: https://bugs.php.net/bug.php?id=75631
# At the time of writing this script the latest commit in the source, https://github.com/php/pecl-search_engine-solr/,
# is de1d724299780d927cb9ed14268449ac8a28204b, dated 2017-09-07.
hash=de1d724299780d927cb9ed14268449ac8a28204b

# Download our 'tagged' source code from git.
echo "Downloading solr extension source archive (${hash})"
curl --location \
	https://github.com/php/pecl-search_engine-solr/archive/${hash}.tar.gz \
	-o /tmp/pecl-search_engine-solr-${hash}.tar.gz
# Extract the compressed archive.
cd /tmp
tar -xvzf pecl-search_engine-solr-${hash}.tar.gz
cd pecl-search_engine-solr-${hash}

# Compile the extension as required by a manual PECL installation.
echo "Compile solr extension"
phpize
./configure
make
# Finally, install it.
echo "Install solr extension"
make install

# Remove all the sources.
echo "Cleanup temporary folder and files"
rm /tmp/pecl-search_engine-solr-${hash} -rf
rm /tmp/pecl-search_engine-solr-${hash}.tar.gz -f

# Done with this hack.
# Please, follow https://github.com/moodlehq/moodle-php-apache/issues/19.
