#!/usr/bin/env bash
climate=$(bash climate-temp.sh)
elevation=$(bash elevation-temp.sh)
variation=$(bash temp-variation.sh)
echo $(( climate + elevation + variation))