#!/usr/bin/env bash
d100=$(bash n-dice-x.sh 1 100)

if [[ ${d100} -le 50 ]]; then
    echo 0
elif [[ ${d100} -le 80 ]]; then
    echo 1
elif [[ ${d100} -le 90 ]]; then
    echo 2
elif [[ ${d100} -le 95 ]]; then
    echo 3
else
    echo 4
fi