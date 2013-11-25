#!/usr/bin/sh
set -eau

set +e
(
	set -e
	cat > composer.json <<EOF
{
    "require": {
        "geoip2/geoip2": "0.5.*"
    }
}
EOF

	mkdir -p database
	(
		cd database
		wget "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz"
		gunzip "GeoLite2-City.mmdb.gz"
		rm -f "GeoLite2-City.mmdb.gz"
	)

	curl -s http://getcomposer.org/installer | php
	php composer.phar install
)
STATUS=$?
if [ $STATUS != 0 ]; then
	echo "ERROR: exit status=${STATUS}"
	exit ${STATUS}
fi

