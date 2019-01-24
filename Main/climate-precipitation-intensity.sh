#!/usr/bin/env bash
climate=$(cat climate.init)
case $climate in
    COLD) echo -1;;
    TEMPERATE) echo 0;;
    TROPICAL) echo 1;;
esac