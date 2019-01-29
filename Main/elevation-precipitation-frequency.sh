#!/usr/bin/env bash
elevation=$(cat ${1}.elevation)
if [[ $elevation == "HIGHLAND" ]]; then
    echo -1
else
    echo 0
fi