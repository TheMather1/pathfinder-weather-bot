#!/usr/bin/env bash
climate=$(bash climate-precipitation-frequency.sh ${1})
elevation=$(bash elevation-precipitation-frequency.sh ${1})
echo $(( climate + elevation ))