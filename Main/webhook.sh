#!/usr/bin/env bash
curl -d "content=$1" $(cat ${2}.url)