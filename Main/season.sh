#!/usr/bin/env bash
date=$( date +%j )
if [ $date -lt 46 ] || [ $date -gt 320 ]; then
    echo "WINTER"
elif [ $date -lt 137 ]; then
    echo "SPRING"
elif [ $date -lt 229 ]; then
    echo "SUMMER"
else
    echo "FALL"
fi