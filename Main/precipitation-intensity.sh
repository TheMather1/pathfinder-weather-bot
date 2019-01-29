#!/usr/bin/env bash
elevation=$(bash elevation-precipitation-intensity.sh ${1})
climate=$(bash climate-precipitation-intensity.sh ${1})
echo $((elevation + climate))