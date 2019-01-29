#!/usr/bin/env bash
temp=$(bash temp.sh ${1})
night_temp=$(( $temp - $(bash n-dice-x.sh 2 6) - 3))

temp_string="The temperature is $temp℉, and drops to $night_temp℉ at night."

bash webhook.sh $temp_string ${1}

