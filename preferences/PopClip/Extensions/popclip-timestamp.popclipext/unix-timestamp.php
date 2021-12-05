<?php
$input = getenv('POPCLIP_TEXT');

date_default_timezone_set('UTC');

function isBetweenDates($ts, $low = '2010-01-01', $high = '2030-01-01') {
  return $ts >= strtotime($low) && $ts <= strtotime($high);
}

if (isBetweenDates($input)) $timestamp = $input;  // seconds
elseif (isBetweenDates($input / 1e3)) $timestamp = $input / 1e3;  // milliseconds
elseif (isBetweenDates($input / 1e6)) $timestamp = $input / 1e6;  // microseconds

echo date("Y-m-d H:i:s", $timestamp);
