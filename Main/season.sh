#!/usr/bin/env bash
if [[ $( date +%j ) -lt 46 ]] || [[ $(date +%j) -gt 320 ]]; then
    echo "WINTER"
elif [[ $( date +%j ) -gt 45 ]] && [[ $( date +%j ) -lt 137 ]]; then
    echo "SPRING"
elif [[ $( date +%j ) -gt 136 ]] && [[ $( date +%j ) -lt 229 ]]; then
    echo "SUMMER"
else
    echo "FALL"
fi