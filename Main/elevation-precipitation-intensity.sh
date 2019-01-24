#!/usr/bin/env bash
elevation=$(cat elevation.init)
case $elevation in
    "SEA LEVEL") echo 2;;
    HIGHLAND) echo 1;;
    LOWLAND) echo 1;;
esac