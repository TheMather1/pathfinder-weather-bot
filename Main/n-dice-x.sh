#!/usr/bin/env bash
output=0
for ((n=0; n<$1; n++)); do
    output=$(($output + 1 + RANDOM % $2 ))
done
echo $output