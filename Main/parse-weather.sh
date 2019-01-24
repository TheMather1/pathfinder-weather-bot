#!/usr/bin/env bash
temp=$(sh temp.sh)
night_temp=$(( $temp - $(sh n-dice-x.sh 2 6) - 3))
temp_string="The temperature is $temp℉, and drops to $night_temp℉ at night."
echo $temp_string