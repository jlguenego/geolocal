<?php

header('Access-Control-Allow-Origin: *');
header("Content-Type:text/plain; charset=UTF-8;");
header('Cache-Control: no-cache, must-revalidate');

require_once 'vendor/autoload.php';
use GeoIp2\Database\Reader;

$reader = new Reader('database/GeoLite2-City.mmdb');

try {
	if (!isset($_GET['ip'])) {
		throw new Exception('No IP given.');
	}
	$ip = $_GET['ip'];
	if (!filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_IPV6)) {
		throw new Exception('No well formed IPv4 or IPv6: ' . $ip);
	}

	$record = $reader->city($ip);
	$result['ip'] = $ip;

	$result['country_isoCode'] = $record->country->isoCode;
	$result['country_name'] = $record->country->name;
	$result['mostSpecificSubdivision_isoCode'] = $record->mostSpecificSubdivision->isoCode;
	$result['mostSpecificSubdivision_name'] = $record->mostSpecificSubdivision->name;
	$result['city_name'] = $record->city->name;
	$result['postal_code'] = $record->postal->code;

	$result['latitude'] = $record->location->latitude;
	$result['longitude'] = $record->location->longitude;
} catch (Exception $e) {
	$result['error'] = $e->getMessage();
}

echo json_encode($result);
?>