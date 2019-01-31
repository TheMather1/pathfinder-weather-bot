#!/usr/bin/env bash
d100=$(bash n-dice-x.sh 1 100)

if [[ ${d100} -le 50 ]]; then
    echo 0
elif [[ ${d100} -le 70 ]]; then
    echo 1
elif [[ ${d100} -le 85 ]]; then
    echo 2
else
    echo 3
fi