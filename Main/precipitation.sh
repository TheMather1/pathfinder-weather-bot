#!/usr/bin/env bash

function lightFog(){
    wind_string=$(bash wind-string.sh 0)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is light fog ${time_string}.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
}

function mediumFog(){
    wind_string=$(bash wind-string.sh 0)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is fog ${time_string}.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
}

function heavyFog(){
    wind_string=$(bash wind-string.sh 0)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is heavy fog ${time_string}.** (Can't see beyond 5 feet. Targets further than 5 feet away have Concealment)"
}

function drizzle(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is a drizzle ${time_string}.** (3/4 visibility. -2 penalty on Perception. Extinguishes tiny unprotected flames.)"
}

function lightRain(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is light rain ${time_string}.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function mediumRain(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is rain ${time_string}.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function heavyRain(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is a rainstorm ${time_string}.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
}

function thunderstorm(){
    wind_strength=$(bash wind-thunderstorm.sh)
    wind_string=$(bash wind-string.sh ${wind_strength})
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is a thunderstorm ${time_string}.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
}

function sleet(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is sleet ${time_string}.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
}

function lightSnow(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is light snowfall ${time_string}.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
}

function mediumSnow(){
    wind_string=$(bash wind-generate.sh)
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is snowfall ${time_string}.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
}

function heavySnow(){
    if [[ $(bash n-dice-x.sh 1 100) -le 10 ]]; then
        thundersnow
    else
        wind_string=$(bash wind-generate.sh)
        if [[ ${wind_strength} -ge 3 &&  $(bash n-dice-x.sh 1 100) -le 40 ]]; then
            blizzard ${1} ${2}
        else
            snowstorm ${1} ${2}
        fi
    fi
}

function snowstorm(){
    time_string=$(bash time-string.sh ${1} ${2})
    precipitation_string="**There is a snowstorm ${time_string}.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
}

function blizzard(){
    if [[ $(bash n-dice-x.sh 1 100) -le 20 ]]; then
        time_string=$(bash time-string.sh ${1} $(( ${1} + $(bash n-dice-x.sh 2 12) )) )
    else
        time_string=$(bash time-string.sh ${1} ${2})
    fi
    precipitation_string="**There is a blizzard ${time_string}.** (Can't see beyond 20 ft. -8 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement. Creatures treat the weather as 20℉ colder than its actual temperature.)"
}

function thundersnow(){
    wind_strength=$(bash wind-thunderstorm.sh)
    wind_string=$(bash wind-string.sh ${wind_strength})
    if [[ ${wind_strength} -ge 3 &&  $(bash n-dice-x.sh 1 100) -le 40 ]]; then
        blizzard ${1} ${2}
    else
        snowstorm ${1} ${2}
    fi
    precipitation_string="${precipitation_string}\n**It is accompanied by a thundersnow.** (Lightning strikes a random unsheltered creature every hour.)"
    if [[ $(bash n-dice-x.sh 1 100) -le 40 ]]; then
        hail
    fi
    if [[ ${wind_strength} -eq 4 ]]; then
        if [[ $(bash n-dice.x.sh 1 100) -le 10 ]]; then
            snownado
        fi
    fi
}

function snownado(){
    precipitation_string="${precipitation_string}\n**This generates a snownado.** (Perception and Ranged Attacks, including Siege Weapons and Evocation Spells, near the snownado are impossible. Nearby creatures of size Huge or smaller must succeed on a DC 20 Strength check to avoid being sucked in.)"
}
intensity=$(bash precipitation-intensity.sh ${1})
frequency=$(bash precipitation-frequency.sh ${1})
d6=$(bash n-dice-x.sh 1 6)
d12=$(bash n-dice-x.sh 1 12)
d100=$(bash n-dice-x.sh 1 100)

if [[ ${d6} -ge 3 ]]; then
    time=$(( d12 + 12 ))
else
    time=${d12}
fi

if [[ ${time} -gt 18 ]] || [[ ${time} -lt 6 ]]; then
    temp=${3}
else
    temp=${2}
fi

if [[ ${frequency} -eq 0 ]]; then
    intensity=$(( ${intensity} - 2 ))
fi

if [[ ${temp} -lt 42 ]]; then
    if [[ ${intensity} -le 0 ]]; then
        if [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            lightFog ${time} ${stop}
        elif [[ ${d100} -le 40 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 6) ))
            lightFog ${time} ${stop}
        elif [[ ${d100} -le 45 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 60 ]]; then
            stop=$(( ${time} + 1 ))
            lightSnow ${time} ${stop}
        elif [[ ${d100} -le 75 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            lightSnow ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            lightSnow ${time} ${stop}
        fi
    fi
    if [[ ${intensity} -eq 1 ]]; then
        if [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 6) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 30 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 50 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            mediumSnow ${time} ${stop}
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumSnow ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            mediumSnow ${time} ${stop}
        fi
    fi
    if [[ ${intensity} -eq 2 ]]; then
        if [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 60 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            lightSnow ${time} ${stop}
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumSnow ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 1 6) ))
            heavySnow ${time} ${stop}
        fi
    fi
    if [[ ${intensity} -eq 3 ]]; then
        if [[ ${d100} -le 5 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 50 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            heavySnow ${time} ${stop}
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            heavySnow ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            heavySnow ${time} ${stop}
        fi
    fi
else
    if [[ ${intensity} -le 0 ]]; then
        if [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 6) ))
            lightFog ${time} ${stop}
        elif [[ ${d100} -le 40 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            lightFog ${time} ${stop}
        elif [[ ${d100} -le 50 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            drizzle ${time} ${stop}
        elif [[ ${d100} -le 75 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            drizzle ${time} ${stop}
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            lightRain ${time} ${stop}
        else
            stop=$(( ${time} + 1 ))
            if [[ ${temp} -lt 40 ]]; then
                sleet ${time} ${stop}
            else
                lightRain ${time} ${stop}
            fi
        fi
    fi
    if [[ ${intensity} -eq 1 ]]; then
        if [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 12) ))
            mediumFog ${time} ${stop}
        elif [[ ${d100} -le 30 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 35 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            mediumRain ${time} ${stop}
        elif [[ ${d100} -le 70 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            mediumRain ${time} ${stop}
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            mediumRain ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 1 4) ))
            if [[ ${temp} -lt 40 ]]; then
                sleet ${time} ${stop}
            else
                mediumRain ${time} ${stop}
            fi
        fi
    fi
    if [[ ${intensity} -eq 2 ]]; then
        if [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 20 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 50 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 12) ))
            heavyRain ${time} ${stop}
        elif [[ ${d100} -le 70 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            if [[ ${temp} -lt 40 ]]; then
                sleet ${time} ${stop}
            else
                heavyRain ${time} ${stop}
            fi
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + 1 ))
            thunderstorm ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 1 3) ))
            thunderstorm ${time} ${stop}
        fi
    fi
    if [[ ${intensity} -eq 3 ]]; then
        if [[ ${d100} -le 5 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 8) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 10 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            heavyFog ${time} ${stop}
        elif [[ ${d100} -le 30 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            heavyRain ${time} ${stop}
        elif [[ ${d100} -le 60 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 12) ))
            heavyRain ${time} ${stop}
        elif [[ ${d100} -le 80 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 2 6) ))
            if [[ ${temp} -lt 40 ]]; then
                sleet ${time} ${stop}
            else
                heavyRain ${time} ${stop}
            fi
        elif [[ ${d100} -le 90 ]]; then
            stop=$(( ${time} + $(bash n-dice-x.sh 1 3) ))
            thunderstorm ${time} ${stop}
        else
            stop=$(( ${time} + $(bash n-dice-x.sh 1 6) ))
            thunderstorm ${time} ${stop}
        fi
    fi
fi

echo "$(bash cloud-description.sh 3)\n${wind_string}\n${precipitation_string}"