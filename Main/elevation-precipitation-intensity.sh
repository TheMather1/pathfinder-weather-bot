#!/usr/bin/env bash
elevation=$(bash get-property.sh ${1} "elevation")
case ${elevation} in
    "SEA LEVEL") echo 2;;
    HIGHLAND) echo 1;;
    LOWLAND) echo 1;;
esac