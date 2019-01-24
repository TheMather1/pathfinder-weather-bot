#!/usr/bin/env bash
elevation=$(cat elevation.init)
if [[ $elevation == "SEA LEVEL" ]]; then
    echo 10
elif [[ $elevation == "HIGHLAND" ]]; then
    echo -10
else
    echo 0
fi