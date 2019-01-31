#!/usr/bin/env bash
frequency=$(bash precipitation-frequency.sh ${1})
d100=$(bash n-dice-x.sh 1 100)

case ${frequency} in
    0) if [[ ${d100} -le 5 ]]; then
            echo true
        else
            echo false
        fi;;
    1) if [[ ${d100} -le 15 ]]; then
            echo true
        else
            echo false
        fi;;
    2) if [[ ${d100} -le 30 ]]; then
            echo true
        else
            echo false
        fi;;
    3) if [[ ${d100} -le 60 ]]; then
            echo true
        else
            echo false
        fi;;
    4) if [[ ${d100} -le 95 ]]; then
            echo true
        else
            echo false
        fi;;
esac