#!/usr/bin/sh
set -eau

. lib/constant.lib.sh
. lib/deploy.lib.sh

set +e
(
	set -e

	make_archive

	deploy_code -u eventbil -p Lx2AdFMz -d "/www/geolocal" ftp.event-biller.com http://event-biller.com/geolocal
)