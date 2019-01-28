#!/usr/bin/env bash
elevation=$(bash elevation-precipitation-intensity.sh)
climate=$(bash climate-precipitation-intensity.sh)
echo $((elevation + climate))