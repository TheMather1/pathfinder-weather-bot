#!/usr/bin/env bash
climate=$(cat climate.init);
season=$(bash season.sh);
case ${season} in
    WINTER) case ${climate} in
        COLD) echo 1;;
        TEMPERATE) echo 1;;
        TROPICAL) echo 1;;
    esac;;
    SPRING) case ${climate} in
        COLD) echo 2;;
        TEMPERATE) echo 2;;
        TROPICAL) echo 3;;
    esac;;
    SUMMER) case ${climate} in
        COLD) echo 3;;
        TEMPERATE) echo 3;;
        TROPICAL) echo 2;;
    esac;;
    FALL) case ${climate} in
        COLD) echo 2;;
        TEMPERATE) echo 2;;
        TROPICAL) echo 3;;
    esac;;
esac