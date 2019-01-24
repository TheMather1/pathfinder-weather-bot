#!/usr/bin/env bash
climate=$(sh climate-temp.sh)
elevation=$(sh elevation-temp.sh)
variation=$(sh temp-variation.sh)
echo $(( climate + elevation + variation))