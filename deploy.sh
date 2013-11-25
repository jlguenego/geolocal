#!/usr/bin/sh
set -eau

. lib/constant.lib.sh
. lib/deploy.lib.sh

set +e
(
	set -e

	make_archive

	deploy_code -u ocpforum -p QQJQnwdw -d "/www" -i "geolocal" ftp.ocpforum.org http://ocpforum.org
)