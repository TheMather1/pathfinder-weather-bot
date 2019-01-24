#!/usr/bin/env bash
elevation=$(cat elevation.init)
case $elevation in
    "SEA LEVEL") echo 10;;
    HIGHLAND) echo -10;;
    LOWLAND) echo 0;;
esac