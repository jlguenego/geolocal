#!/usr/bin/sh
set -eau

TMP_FILE="/tmp/tmp.txt"

set +e
(
	set -e

	IP="80.24.24.24"
	URL="http://localhost/geolocal"
	if [ $# -gt 0 ]; then
		IP="${1}"
		shift
	fi

	if [ $# -gt 0 ]; then
		URL="${1}"
		shift
	fi

curl -sf "${URL}/geoloc.php?ip=${IP}" > "${TMP_FILE}" || { echo "curl failed..."; exit 1; }

	cat "${TMP_FILE}" | python -mjson.tool
	rm -rf "${TMP_FILE}"
)
STATUS=$?
rm -rf "${TMP_FILE}"
if [ $STATUS != 0 ]; then
	echo "ERROR: exit status=${STATUS}"
	exit ${STATUS}
fi
