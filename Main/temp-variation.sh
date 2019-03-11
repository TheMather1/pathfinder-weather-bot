#!/usr/bin/env bash
climate=$(bash get-property.sh ${1} "climate")

if [[ -f "${1}.tempVariation" ]]; then
    d100=$(cat "$1.tempVariation")
    new=false
else
    d100=$(bash n-dice-x.sh 1 100)
    touch "${1}.tempVariation"
    echo ${d100} > "$1.tempVariation"
    new=true
fi
case ${climate} in
    COLD)
        if [[ ${d100} -lt 21 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 3 10) ))
            delay=$(bash n-dice-x.sh 1 4)
        elif [[ ${d100} -lt 41 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 2 10) ))
            delay=$(( 1 + $(bash n-dice-x.sh 1 6) ))
        elif [[ ${d100} -lt 61 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 1 10) ))
            delay=$(( 2 + $(bash n-dice-x.sh 1 6) ))
        elif [[ ${d100} -lt 81 ]]; then
            echo 0
            delay=$(( 1 + $(bash n-dice-x.sh 1 6) ))
        elif [[ ${d100} -lt 96 ]]; then
            echo $(bash n-dice-x.sh 1 10)
            delay=$(( 1 + $(bash n-dice-x.sh 1 6) ))
        elif [[ ${d100} -lt 100 ]]; then
            echo $(bash n-dice-x.sh 2 10)
            delay=$(bash n-dice-x.sh 1 4)
        else
            echo $(bash n-dice-x.sh 3 10)
            delay=$(bash n-dice-x.sh 1 2)
        fi;;
    TEMPERATE)
        if [[ ${d100} -lt 6 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 3 10) ))
            delay=$(bash n-dice-x.sh 1 2)
        elif [[ ${d100} -lt 16 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 2 10) ))
            delay=$(bash n-dice-x.sh 1 4)
        elif [[ ${d100} -lt 36 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 1 10) ))
            delay=$(( 1 + $(bash n-dice-x.sh 1 4) ))
        elif [[ ${d100} -lt 66 ]]; then
            echo 0
            delay=$(( 1 + $(bash n-dice-x.sh 1 6) ))
        elif [[ ${d100} -lt 86 ]]; then
            echo $(bash n-dice-x.sh 1 10)
            delay=$(( 1 + $(bash n-dice-x.sh 1 4) )) 
        elif [[ ${d100} -lt 96 ]]; then
            echo $(bash n-dice-x.sh 2 10)
            delay=$(bash n-dice-x.sh 1 4) 
        else
            echo $(bash n-dice-x.sh 3 10)
            delay=$(bash n-dice-x.sh 1 2)
        fi;;
    TROPICAL)
        if [[ ${d100} -lt 11 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 2 10) ))
            delay=$(bash n-dice-x.sh 1 2)
        elif [[ ${d100} -lt 26 ]]; then
            echo $(( 0 - $(bash n-dice-x.sh 1 10) ))
            delay=$(bash n-dice-x.sh 1 2)
        elif [[ ${d100} -lt 56 ]]; then
            echo 0
            delay=$(bash n-dice-x.sh 1 4)
        elif [[ ${d100} -lt 86 ]]; then
            echo $(bash n-dice-x.sh 1 10)
            delay=$(bash n-dice-x.sh 1 4)
        else
            echo $(bash n-dice-x.sh 2 10)
            delay=$(bash n-dice-x.sh 1 2)
        fi;;
esac

if ${new}; then
    echo "rm -f ${1}.tempVariation" | at now +$(( ${delay} * 2 - 1 )) minutes
fi