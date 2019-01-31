#!/usr/bin/env bash
climate=$(bash climate-temp.sh ${1})
elevation=$(bash elevation-temp.sh ${1})
variation=$(bash temp-variation.sh ${1})
clouds=$(bash cloud-temp.sh ${2})
echo $(( ${climate} + ${elevation} + ${variation} + ${clouds} ))