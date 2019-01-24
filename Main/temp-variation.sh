#!/usr/bin/env bash
climate=$(cat climate.init)
d100=$(sh n-dice-x.sh 1 100)
case $climate in
    COLD)
        if [[ $d100 -lt 21 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 3 10) ))
        elif [[ $d100 -lt 41 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 2 10) ))
        elif [[ $d100 -lt 61 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 1 10) ))
        elif [[ $d100 -lt 81 ]]; then
            echo 0
        elif [[ $d100 -lt 96 ]]; then
            echo $(sh n-dice-x.sh 1 10)
        elif [[ $d100 -lt 100 ]]; then
            echo $(sh n-dice-x.sh 2 10)
        else
            echo $(sh n-dice-x.sh 3 10)
        fi;;
    TEMPERATE)
        if [[ $d100 -lt 6 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 3 10) ))
        elif [[ $d100 -lt 16 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 2 10) ))
        elif [[ $d100 -lt 36 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 1 10) ))
        elif [[ $d100 -lt 66 ]]; then
            echo 0
        elif [[ $d100 -lt 86 ]]; then
            echo $(sh n-dice-x.sh 1 10)
        elif [[ $d100 -lt 96 ]]; then
            echo $(sh n-dice-x.sh 2 10)
        else
            echo $(sh n-dice-x.sh 3 10)
        fi;;
    TROPICAL)
        if [[ d100 -lt 11 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 2 10) ))
        elif [[ $d100 -lt 26 ]]; then
            echo $(( 0 - $(sh n-dice-x.sh 1 10) ))
        elif [[ $d100 -lt 56 ]]; then
            echo 0
        elif [[ $d100 -lt 86 ]]; then
            echo $(sh n-dice-x.sh 1 10)
        else
            echo $(sh n-dice-x.sh 2 10)
        fi;;
esac