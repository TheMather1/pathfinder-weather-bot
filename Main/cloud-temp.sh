#!/usr/bin/env bash
season=$(bash season.sh)

if [[ ${1} -eq 3 ]]; then
    case ${season} in
        WINTER) echo 10;;
        SPRING) echo -10;;
        SUMMER) echo -10;;
        FALL) echo 10;;
    esac
else
    echo 0
fi