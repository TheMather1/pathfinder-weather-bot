#!/usr/bin/env bash
output=0
for ((n=$1; n>0; n--)); do
    output=$((output + 1 + RANDOM % $2 ))
done
echo $output