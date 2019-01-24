#!/usr/bin/env bash
elevation=$(cat elevation.init)
if [[ $elevation == "HIGHLAND" ]]; then
    echo -1
else
    echo 0
fi