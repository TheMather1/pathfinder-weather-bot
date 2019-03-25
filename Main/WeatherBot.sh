#!/usr/bin/env bash
climate=$(grep "climate" ${1} | cut -d '=' -f2)
elevation=$(grep "elevation" ${1} | cut -d '=' -f2)
weatherHook=$(grep "url" ${1} | cut -d '=' -f2)
forecastHook=$(grep "forecast_url" ${1} | cut -d '=' -f2)

function season(){

    date=$( date +%j )
    if [[ ${date#0} -lt 46 ]] || [[ ${date#0} -gt 320 ]]; then
        echo "WINTER"
    elif [[ ${date#0} -lt 137 ]]; then
        echo "SPRING"
    elif [[ ${date#0} -lt 229 ]]; then
        echo "SUMMER"
    else
        echo "FALL"
    fi
}

function dice(){
    for ((n=0; ${n}<${1}; n++)); do
        result=$(( ${result:=0} + 1 + RANDOM % $2 ))
    done
    echo ${result}
}

function precipitationBool(){
    case $(precipitationFrequency) in
        0) if [[ $(dice 1 100) -le 5 ]]; then
                echo 1
            else
                echo 0
            fi;;
        1) if [[ $(dice 1 100) -le 15 ]]; then
                echo 1
            else
                echo 0
            fi;;
        2) if [[ $(dice 1 100) -le 30 ]]; then
                echo 1
            else
                echo 0
            fi;;
        3) if [[ $(dice 1 100) -le 60 ]]; then
                echo 1
            else
                echo 0
            fi;;
        4) if [[ $(dice 1 100) -le 95 ]]; then
                echo 1
            else
                echo 0
            fi;;
    esac
}

function precipitationFrequency(){
    if [[ ${elevation} = "HIGHLAND" ]]; then
        highland=1
    else
        highland=0
    fi
    case ${climate} in
        COLD) case $(season) in
            WINTER) echo $(( 1 - ${highland} ));;
            SPRING) echo $(( 2 - ${highland} ));;
            SUMMER) echo $(( 3 - ${highland} ));;
            FALL) echo $(( 2 - ${highland} ));;
        esac;;
        TEMPERATE) case $(season) in
            WINTER) echo $(( 1 - ${highland} ));;
            SPRING) echo $(( 2 - ${highland} ));;
            SUMMER) echo $(( 3 - ${highland} ));;
            FALL) echo $(( 2 - ${highland} ));;
        esac;;
        TROPICAL) case $(season) in
            WINTER) echo $(( 1 - ${highland} ));;
            SPRING) echo $(( 3 - ${highland} ));;
            SUMMER) echo $((2 - ${highland}));;
            FALL) echo $((3 - ${highland}));;
        esac;;
    esac
}

function precipitationIntensity(){
    case ${elevation} in
        "SEA LEVEL") intensity=2;;
        HIGHLAND) intensity=1;;
        LOWLAND) intensity=1;;
        esac
    case ${climate} in
        COLD) (( intensity -= 1 ));;
        TROPICAL) (( intensity += 1 ));;
    esac
    if [[ $(precipitationFrequency) -eq 0 ]]; then
        echo $(( ${intensity} - 1 ))
    else
        echo ${intensity}
    fi
}

function clouds(){
    cloudType=$(dice 1 100)
    if [[ ${cloudType} -le 50 ]]; then
        clouds="**The sky is clear.**"
        overcast=0
    elif [[ ${cloudType} -le 70 ]]; then
        clouds="**There are a few clouds.**"
        overcast=0
    elif [[ ${cloudType} -le 85 ]]; then
        clouds="**The sky is cloudy.**"
        overcast=0
    else
        clouds="**The sky is completely overcast.** (Flying creatures at high altitudes have Concealment.)"
        overcast=1
    fi
}

function temperature(){
    case ${climate} in
        COLD) case $(season) in
            WINTER) dayTemp=20;;
            SPRING) dayTemp=30;;
            SUMMER) dayTemp=40;;
            FALL) dayTemp=2;;
        esac;;
        TEMPERATE) case $(season) in
            WINTER) dayTemp=30;;
            SPRING) dayTemp=60;;
            SUMMER) dayTemp=80;;
            FALL) dayTemp=60;;
        esac;;
        TROPICAL) case $(season) in
            WINTER) dayTemp=50;;
            SPRING) dayTemp=75;;
            SUMMER) dayTemp=95;;
            FALL) dayTemp=75;;
        esac;;
    esac
    case ${elevation} in
        "SEA LEVEL") (( dayTemp += 10 ));;
        HIGHLAND) (( dayTemp -= 10 ));;
    esac
    tempWave
    if [[ ${1} -eq 1 ]]; then
        case $(season) in
            WINTER) (( dayTemp += 10 ));;
            SPRING) (( dayTemp -= 10 ));;
            SUMMER) (( dayTemp -= 10 ));;
            FALL) (( dayTemp += 10 ));;
        esac
    fi
    nightTemp=$(( dayTemp - 3 - $(dice 2 6) ))
    tempString="**The temperature is ${dayTemp}℉, and drops to ${nightTemp}℉ at night.**"
}

function tempWave(){
    if [[ ${tempWaveDuration:=0} > 0 ]]; then
        (( tempWaveDuration-- ))
    else
        tempWaveRange=$(dice 1 100)
        case ${climate} in
        COLD)
            if [[ ${tempWaveRange} -lt 21 ]]; then
                tempWave="expr 0 - \$(dice 3 10)"
                tempWaveDuration=$(dice 1 4)
            elif [[ ${tempWaveRange} -lt 41 ]]; then
                tempWave="expr 0 - \$(dice 2 10)"
                tempWaveDuration=$(( 1 + $(dice 1 6) ))
            elif [[ ${tempWaveRange} -lt 61 ]]; then
                tempWave="expr 0 - \$(dice 1 10)"
                tempWaveDuration=$(( 2 + $(dice 1 6) ))
            elif [[ ${tempWaveRange} -lt 81 ]]; then
                tempWave="expr 0"
                tempWaveDuration=$(( 1 + $(dice 1 6) ))
            elif [[ ${tempWaveRange} -lt 96 ]]; then
                tempWave="dice 1 10"
                tempWaveDuration=$(( 1 + $(dice 1 6) ))
            elif [[ ${tempWaveRange} -lt 100 ]]; then
                tempWave="dice 2 10"
                tempWaveDuration=$(dice 1 4)
            else
                tempWave="dice 3 10"
                tempWaveDuration=$(dice 1 2)
            fi;;
        TEMPERATE)
            if [[ ${tempWaveRange} -le 5 ]]; then
                tempWave="expr 0 - \$(dice 3 10)"
                tempWaveDuration=$(dice 1 2)
            elif [[ ${tempWaveRange} -le 15 ]]; then
                tempWave="expr 0 - \$(dice 2 10)"
                tempWaveDuration=$(dice 1 4)
            elif [[ ${tempWaveRange} -le 35 ]]; then
                tempWave="expr 0 - \$(dice 1 10)"
                tempWaveDuration=$(( 1 + $(dice 1 4) ))
            elif [[ ${tempWaveRange} -le 65 ]]; then
                tempWave="expr 0"
                tempWaveDuration=$(( 1 + $(dice 1 6) ))
            elif [[ ${tempWaveRange} -le 85 ]]; then
                tempWave="dice 1 10"
                tempWaveDuration=$(( 1 + $(dice 1 4) ))
            elif [[ ${tempWaveRange} -le 95 ]]; then
                tempWave="dice 2 10"
                tempWaveDuration=$(dice 1 4)
            else
                tempWave="dice 3 10"
                tempWaveDuration=$(dice 1 2)
            fi;;
        TROPICAL)
            if [[ ${tempWaveRange} -lt 11 ]]; then
                tempWave="expr 0 - \$(dice 2 10)"
                tempWaveDuration=$(dice 1 2)
            elif [[ ${tempWaveRange} -lt 26 ]]; then
                tempWave="expr 0 - \$(dice 1 10)"
                tempWaveDuration=$(dice 1 2)
            elif [[ ${tempWaveRange} -lt 56 ]]; then
                tempWave="expr 0"
                tempWaveDuration=$(dice 1 4)
            elif [[ ${tempWaveRange} -lt 86 ]]; then
                tempWave="dice 1 10"
                tempWaveDuration=$(dice 1 4)
            else
                tempWave="dice 2 10"
                tempWaveDuration=$(dice 1 2)
            fi;;
        esac
    fi
    dayTemp=$(expr ${dayTemp} + $(eval ${tempWave}) )
}

function windStrength(){
    windRange=$(dice 1 100)
    if [[ ${windRange} -le 50 ]]; then
        windStrength=0
    elif [[ ${windRange} -le 80 ]]; then
        windStrength=1
    elif [[ ${windRange} -le 90 ]]; then
        windStrength=2
    elif [[ ${windRange} -le 95 ]]; then
        windStrength=3
    else
        windStrength=4
    fi
}

function windString(){
    case ${windStrength} in
        0) windString="**It is almost completely windstill.**";;
        1) windString="**There's a comfortable breeze.**";;
        2) windString="**There's a notable wind. **(Creatures of size Tiny or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Ranged Weapon Attacks and Skill checks affected by wind take a -2 penalty.)";;
        3) windString="**There's a strong wind. **(Creatures of size Siny or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Creatures of size Tiny or smaller are at risk of being blown away. Ranged Weapon Attacks and Skill checks affected by wind take a -4 penalty.)";;
        4) windString="**There's a storm. **(Creatures of size Medium or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Creatures of size Small or smaller are at risk of being blown away. Skill checks affected by wind take a -8 Penalty. Ranged Weapon Attacks are impossible and Ranged Siege Attacks take a -4 penalty.)";;
    esac
}

function precipitation(){
    precipitationRange=$(dice 1 100)
    windStrength
    windString
    
    if [[ $(dice 1 6) -ge 3 ]]; then
        time=$(( $(dice 1 12) + 12 ))
    else
        time=$(dice 1 12)
    fi
    
    if [[ ${time} -gt 18 ]] || [[ ${time} -lt 6 ]]; then
        temp=${dayTemp}
    else
        temp=${nightTemp}
    fi
    
    if [[ ${temp} -lt 42 ]]; then
        if [[ $(precipitationIntensity) -le 0 ]]; then
            if [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                lightFog
            elif [[ ${precipitationRange} -le 40 ]]; then
                duration=$(( ${time} + $(dice 1 6) ))
                lightFog
            elif [[ ${precipitationRange} -le 45 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                mediumFog
            elif [[ ${precipitationRange} -le 60 ]]; then
                duration=$(( ${time} + 1 ))
                lightSnow
            elif [[ ${precipitationRange} -le 75 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                lightSnow
            else
                duration=$(( ${time} + $(dice 2 12) ))
                lightSnow
            fi
        fi
        if [[ $(precipitationIntensity) -eq 1 ]]; then
            if [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 1 6) ))
                mediumFog
            elif [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumFog
            elif [[ ${precipitationRange} -le 30 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                heavyFog
            elif [[ ${precipitationRange} -le 50 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                mediumSnow
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumSnow
            else
                duration=$(( ${time} + $(dice 2 12) ))
                mediumSnow
            fi
        fi
        if [[ $(precipitationIntensity) -eq 2 ]]; then
            if [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumFog
            elif [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                heavyFog
            elif [[ ${precipitationRange} -le 60 ]]; then
                duration=$(( ${time} + $(dice 2 12) ))
                lightSnow
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumSnow
            else
                duration=$(( ${time} + $(dice 1 6) ))
                heavySnow
            fi
        fi
        if [[ $(precipitationIntensity) -eq 3 ]]; then
            if [[ ${precipitationRange} -le 5 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                heavyFog
            elif [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                heavyFog
            elif [[ ${precipitationRange} -le 50 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                heavySnow
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                heavySnow
            else
                duration=$(( ${time} + $(dice 2 12) ))
                heavySnow
            fi
        fi
    else
        if [[ $(precipitationIntensity) -le 0 ]]; then
            if [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 1 6) ))
                lightFog
            elif [[ ${precipitationRange} -le 40 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                lightFog
            elif [[ ${precipitationRange} -le 50 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                drizzle
            elif [[ ${precipitationRange} -le 75 ]]; then
                duration=$(( ${time} + $(dice 2 12) ))
                drizzle
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                lightRain
            else
                duration=$(( ${time} + 1 ))
                if [[ ${temp} -lt 40 ]]; then
                    sleet
                else
                    lightRain
                fi
            fi
        fi
        if [[ $(precipitationIntensity) -eq 1 ]]; then
            if [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumFog
            elif [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 1 12) ))
                mediumFog
            elif [[ ${precipitationRange} -le 30 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                heavyFog
            elif [[ ${precipitationRange} -le 35 ]]; then
                duration=$(( ${time} + $(dice 1 4) ))
                mediumRain
            elif [[ ${precipitationRange} -le 70 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                mediumRain
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 2 12) ))
                mediumRain
            else
                duration=$(( ${time} + $(dice 1 4) ))
                if [[ ${temp} -lt 40 ]]; then
                    sleet
                else
                    mediumRain
                fi
            fi
        fi
        if [[ $(precipitationIntensity) -eq 2 ]]; then
            if [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                heavyFog
            elif [[ ${precipitationRange} -le 20 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                heavyFog
            elif [[ ${precipitationRange} -le 50 ]]; then
                duration=$(( ${time} + $(dice 1 12) ))
                heavyRain
            elif [[ ${precipitationRange} -le 70 ]]; then
                duration=$(( ${time} + $(dice 2 12) ))
                if [[ ${temp} -lt 40 ]]; then
                    sleet
                else
                    heavyRain
                fi
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + 1 ))
                thunderstorm
            else
                duration=$(( ${time} + $(dice 1 3) ))
                thunderstorm
            fi
        fi
        if [[ $(precipitationIntensity) -eq 3 ]]; then
            if [[ ${precipitationRange} -le 5 ]]; then
                duration=$(( ${time} + $(dice 1 8) ))
                heavyFog
            elif [[ ${precipitationRange} -le 10 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                heavyFog
            elif [[ ${precipitationRange} -le 30 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                heavyRain
            elif [[ ${precipitationRange} -le 60 ]]; then
                duration=$(( ${time} + $(dice 2 12) ))
                heavyRain
            elif [[ ${precipitationRange} -le 80 ]]; then
                duration=$(( ${time} + $(dice 2 6) ))
                if [[ ${temp} -lt 40 ]]; then
                    sleet
                else
                    heavyRain
                fi
            elif [[ ${precipitationRange} -le 90 ]]; then
                duration=$(( ${time} + $(dice 1 3) ))
                thunderstorm
            else
                duration=$(( ${time} + $(dice 1 6) ))
                thunderstorm
            fi
        fi
    fi
}

function timeString(){
    if [[ $(( ${time}-${duration} )) -ge 24 ]]; then
        next_day=true
    else
        next_day=false
    fi
    
    duration=$(( ${duration} % 24 ))
    
    if [[ ${time} -eq 24 ]]; then
        start="midnight"
    elif [[ ${time} -gt 12 ]]; then
        start="$(( time - 12 )) PM"
    elif [[ ${time} -eq 12 ]]; then
        start="noon"
    else
        start="${time} AM"
    fi
    
    if [[ ${duration} -eq 24 ]]; then
        stop="midnight"
    elif [[ ${duration} -gt 12 ]]; then
        stop="$(( ${duration} - 12 )) PM"
    elif [[ ${duration} -eq 12 ]]; then
        stop="noon"
    else
        stop="${duration} AM"
    fi
    
    if ${next_day}; then
        echo "from ${start} to ${stop} the next day"
    else
        echo "from ${start} to ${stop}"
    fi
}

function fogWind(){
    windStrength=0
    windString
}

function thunderWind(){
    windRange=$(dice 1 100)
    if [[ ${windRange} -le 50 ]]; then
        windStrength=2
    elif [[ ${windRange} -le 90 ]]; then
        windStrength=3
    else
        windStrength=4
    fi
    windString
}

function lightFog(){
    fogWind
    precipitationString="**There is light fog $(timeString).** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
}

function mediumFog(){
    fogWind
    precipitationString="**There is fog $(timeString).** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
}

function heavyFog(){
    fogWind
    precipitationString="**There is heavy fog $(timeString).** (Can't see beyond 5 feet. Targets further than 5 feet away have Concealment)"
}

function drizzle(){
    fogWind
    precipitationString="**There is a drizzle $(timeString).** (3/4 visibility. -2 penalty on Perception. Extinguishes tiny unprotected flames.)"
}

function lightRain(){
    fogWind
    precipitationString="**There is light rain $(timeString).** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function mediumRain(){
    fogWind
    precipitationString="**There is rain $(timeString).** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function heavyRain(){
    fogWind
    precipitationString="**There is a rainstorm $(timeString).** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
}

function thunderstorm(){
    thunderWind
    precipitationString="**There is a thunderstorm $(timeString).** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Lightning strikes a random unsheltered creature every 10 minutes.)"
    if [[ $(dice 1 100) -le 40 ]]; then
        hail
    fi
    if [[ ${windStrength} -eq 90 ]]; then
        if [[ $(dice 1 100) -le 10 ]]; then
            tornado
        fi
        if [[ ${temp} -gt 85 && $(dice 1 100) -le 20 ]]; then
            hurricane
        fi
    fi
}

function sleet(){
    precipitationString="**There is sleet $(timeString).** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
}

function lightSnow(){
    precipitationString="**There is light snowfall $(timeString).** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
}

function mediumSnow(){
    precipitationString="**There is snowfall $(timeString).** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function heavySnow(){
    if [[ $(dice 1 100) -le 10 ]]; then
        thundersnow
    else
        if [[ ${windStrength} -ge 3 &&  $(dice 1 100) -le 40 ]]; then
            blizzard
        else
            snowstorm
        fi
    fi
}

function snowstorm(){
    precipitationString="**There is a snowstorm $(timeString).** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
}

function blizzard(){
    if [[ $(dice 1 100) -le 20 ]]; then
        duration=$(( ${time} + $(dice 2 12) ))
    fi
    precipitationString="**There is a blizzard $(timeString).** (Can't see beyond 20 ft. -8 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement. Creatures treat the weather as 20℉ colder than its actual temperature.)"
}

function thundersnow(){
    thunderWind
    if [[ ${windStrength} -ge 3 &&  $(dice 1 100) -le 40 ]]; then
        blizzard
    else
        snowstorm
    fi
    precipitationString="${precipitationString}\n**It is accompanied by a thundersnow.** (Lightning strikes a random unsheltered creature every 10 minutes.)"
    if [[ $(dice 1 100) -le 40 ]]; then
        hail
    fi
    if [[ ${windStrength} -eq 4 && $(dice 1 100) -le 10 ]]; then
        snownado
    fi
}

function snownado(){
    precipitationString="${precipitationString}\n**This generates a snownado.** (Perception checks and Ranged Attacks, including Siege Weapons and Evocation Spells, near the snownado are impossible. Nearby creatures of size Huge or smaller must succeed on a DC 20 Strength check to avoid being sucked in.)"
}

function tornado(){
    precipitationString="${precipitationString}\n**This generates a tornado.** (Perception checks and Ranged Attacks, including Siege Weapons and Evocation Spells, near the tornado are impossible. Nearby creatures of size Huge or smaller must succeed on a DC 20 Strength check to avoid being sucked in.)"
}

function hurricane(){
    precipitationString="${precipitationString}\n**Signs of a hurricane can be seen on the horizon.**"
}

function hail(){
    if [[ $(dice 1 100) -le 5 ]]; then
        precipitationString="${precipitationString}\n**Leading up to which there is an hour of heavy hail.** (-4 on sound-based Perception checks. Unsheltered creatures take 1d4 damage per minute.)"
    else
        precipitationString="${precipitationString}\n**Leading up to which there is an hour of hail.** (-4 on sound-based Perception checks.)"
    fi
}

function weather(){
    if [[ $(precipitationBool) -eq 1 ]]; then
        clouds="**The sky is completely overcast.** (Flying creatures at high altitudes have Concealment.)"
        temperature 0
        precipitation
        newWeather="${clouds}\n${windString}\n${precipitationString}\n${tempString}"
    else
        clouds
        temperature ${overcast}
        windStrength
        windString
        newWeather="${clouds}\n${windString}\n${tempString}"
    fi
    echo -e ${newWeather}
}

function execute(){
    curl ${weatherHook} -d "content=$(echo -e ${tomorrowsWeather:="The bot was started today, please wait 2 days so the weather may catch up to the forecast."})"
    tomorrowsWeather=${newWeather:="The bot was started yesterday, please wait another day so the weather may catch up to the forecast."}
    weather
    curl ${forecastHook} -d "content=$(echo -e "($(date --date='2 day' +'%d%m%Y')):\n${newWeather}")"
}

while true; do
    execute
    sleep $(( $(date -d "tomorrow 0 EST" +%s) - $(date +%s) ))
done