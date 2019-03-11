#!/usr/bin/env bash
elevation=$(bash get-property.sh ${1} "elevation")
if [[ ${elevation} == "HIGHLAND" ]]; then
    echo -1
else
    echo 0
fi