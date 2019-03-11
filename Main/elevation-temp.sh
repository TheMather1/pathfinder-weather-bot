#!/usr/bin/env bash
elevation=$(bash get-property.sh ${1} "elevation")
case ${elevation} in
    "SEA LEVEL") echo 10;;
    HIGHLAND) echo -10;;
    LOWLAND) echo 0;;
esac