#!/usr/bin/env bash
climate=$(cat ${1}.climate)
case $climate in
    COLD) echo -1;;
    TEMPERATE) echo 0;;
    TROPICAL) echo 1;;
esac