#!/usr/bin/env bash
elevation=$(sh elevation-precipitation-intensity.sh)
climate=$(sh climate-precipitation-intensity.sh)
echo $((elevation + climate))