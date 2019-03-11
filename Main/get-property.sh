#!/usr/bin/env bash
echo $(grep -o -P "(?<=${2}=).*" ${1}.properties)