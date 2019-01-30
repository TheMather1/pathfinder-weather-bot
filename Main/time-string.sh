#!/usr/bin/env bash
start=${1}
stop=${2}

if [ $(( $stop - start )) -ge 24 ]; then
    next_day=true
else
    next_day=false
fi

if [ $stop -gt 24 ]; then
    stop=$(( stop - 24 ))
fi

if [ $start -eq 24 ]; then
    start="midnight"
elif [ $start -gt 12 ]; then
    start="$(( $start - 12 )) PM"
elif [ $start -eq 12 ]; then
    start="noon"
else
    start="$start AM"
fi

if [ $stop -eq 24 ]; then
    stop="midnight"
elif [ $stop -gt 12 ]; then
    stop="$(( $stop - 12 )) PM"
elif [ $stop -eq 12 ]; then
    stop="noon"
else
    stop="$stop AM"
fi

if $next_day; then
    echo "from $start to $stop the next day"
else
    echo "from $start to $stop"
fi