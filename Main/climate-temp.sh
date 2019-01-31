#!/usr/bin/env bash
climate=$(cat ${1}.climate)
season=$(bash season.sh)
case ${season} in
    WINTER) case ${climate} in
        COLD) echo 20;;
        TEMPERATE) echo 30;;
        TROPICAL) echo 50;;
    esac;;
    SPRING) case ${climate} in
        COLD) echo 30;;
        TEMPERATE) echo 60;;
        TROPICAL) echo 75;;
    esac;;
    SUMMER) case ${climate} in
        COLD) echo 40;;
        TEMPERATE) echo 80;;
        TROPICAL) echo 95;;
    esac;;
    FALL) case ${climate} in
        COLD) echo 40;;
        TEMPERATE) echo 60;;
        TROPICAL) echo 75;;
    esac;;
esac