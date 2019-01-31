#!/usr/bin/env bash
curl -d "content=$(echo -e ${1})" $(cat ${2})