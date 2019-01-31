#!/usr/bin/env bash
precipitation_bool=$(bash precipitation-boolean.sh ${1})

if ${precipitation_bool}; then
    temp=$(bash temp.sh ${1} 0)
    night_temp=$(( $temp - $(bash n-dice-x.sh 2 6) - 3))

    precipitation_string=$(bash precipitation.sh ${1} temp night_temp)
else
    clouds=$(bash cloud-cover.sh)
    temp=$(bash temp.sh ${1} ${clouds})
    night_temp=$(( $temp - $(bash n-dice-x.sh 2 6) - 3))

    precipitation_string=$(bash cloud-description.sh ${clouds})
fi

temp_string="**The temperature is $temp℉, and drops to $night_temp℉ at night.**"

output_string="${temp_string}\n${precipitation_string}"

bash webhook.sh "($( date --date='2 day' +'%d/%m/%Y' )):\n${output_string}" ${1}.forecastUrl
echo bash webhook.sh \"${output_string}\" ${1}.url | at now + 4 minutes

echo bash parse-weather.sh ${1} | at now +2 minutes