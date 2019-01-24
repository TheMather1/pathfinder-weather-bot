#!/usr/bin/env bash
climate=$(cat climate.init)
if [[ $( date +%j ) -lt 46 ]] || [[ $(date +%j) -gt 320 ]]; then
    if [[ $climate  == "COLD" ]]; then
        echo 20;
    fi
    if [[ $climate  == "TEMPERATE" ]]; then
        echo 30;
    fi
    if [[ $climate  == "TROPICAL" ]]; then
        echo 50;
    fi
elif [[ $( date +%j ) -gt 45 ]] && [[ $( date +%j ) -lt 137 ]]; then
    if [[ $climate  == "COLD" ]]; then
        echo 30;
    fi
    if [[ $climate  == "TEMPERATE" ]]; then
        echo 60;
    fi
    if [[ $climate  == "COLD" ]]; then
        echo 75;
    fi
elif [[ $( date +%j ) -gt 136 ]] && [[ $( date +%j ) -lt 229 ]]; then
    if [[ $climate  == "COLD" ]]; then
        echo 40;
    fi
    if [[ $climate  == "TEMPERATE" ]]; then
        echo 80;
    fi
    if [[ $climate  == "TROPICAL" ]]; then
        echo 95;
    fi
else
    if [[ $climate  == "COLD" ]]; then
        echo 40;
    fi
    if [[ $climate  == "TEMPERATE" ]]; then
        echo 60;
    fi
    if [[ $climate  == "TROPICAL" ]]; then
        echo 75;
    fi
fi