#!/usr/bin/env bash
intensity=$(bash precipitation-intensity.sh ${1})
frequency=$(bash precipitation-frequency.sh ${1})
d6=$(bash n-dice-x.sh 1 6)
d12=$(bash n-dice-x.sh 1 12)
d100=$(bash n-dice-x.sh 1 100)

if [ $d6 -ge 3 ]; then
    time=$(( d12 + 12 ))
else
    time=$d12
fi

if [ $time -gt 18 ] || [ $time -lt 6 ]; then
    temp=${3}
else
    temp=${2}
fi

if [ $frequency -eq 0 ]; then
    intensity=$(( $intensity - 2 ))
fi

if [ $temp -lt 42 ]; then
    if [ $intensity -le 0 ]; then
        if [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light fog $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 40 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light fog $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 45 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 60 ]; then
            stop=$(( $time + 1 ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light snowfall $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
        elif [ $d100 -le 75 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light snowfall $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
        else
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light snowfall $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
        fi
    fi
    if [ $intensity -eq 1 ]; then
        if [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 30 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 50 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is snowfall $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is snowfall $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        else
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is snowfall $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        fi
    fi
    if [ $intensity -eq 2 ]; then
        if [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 60 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light snowfall $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is snowfall $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        else
            stop=$(( $time + $(bash n-dice-x.sh 1 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a snowstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
        fi
    fi
    if [ $intensity -eq 3 ]; then
        if [ $d100 -le 5 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 50 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a snowstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a snowstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
        else
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a snowstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. Moving into a square requires 5 additional feet of movement.)"
        fi
    fi
else
    if [ $intensity -le 0 ]; then
        if [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light fog $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 40 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light fog $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 50 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a drizzle $time_string.** (3/4 visibility. -2 penalty on Perception. Extinguishes tiny unprotected flames.)"
        elif [ $d100 -le 75 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a drizzle $time_string.** (3/4 visibility. -2 penalty on Perception. Extinguishes tiny unprotected flames.)"
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is light rain $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        else
            stop=$(( $time + 1 ))
            time_string=$(bash time-string.sh $time $stop)
            if [ $temp -lt 40 ]; then
                echo "**There is sleet $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
            else
                echo "**There is light rain $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
            fi
        fi
    fi
    if [ $intensity -eq 1 ]; then
        if [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is fog $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks.)"
        elif [ $d100 -le 30 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 35 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is rain $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        elif [ $d100 -le 70 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is rain $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is rain $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        else
            stop=$(( $time + $(bash n-dice-x.sh 1 4) ))
            time_string=$(bash time-string.sh $time $stop)
            if [ $temp -lt 40 ]; then
                echo "**There is sleet $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
            else
                echo "**There is rain $time_string.** (1/2 visibility. -4 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
            fi
        fi
    fi
    if [ $intensity -eq 2 ]; then
        if [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 20 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 50 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy rain $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
        elif [ $d100 -le 70 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            if [ $temp -lt 40 ]; then
                echo "**There is sleet $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
            else
                echo "**There is heavy rain $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
            fi
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + 1 ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a thunderstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
        else
            stop=$(( $time + $(bash n-dice-x.sh 1 3) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a thunderstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        fi
    fi
    if [ $intensity -eq 3 ]; then
        if [ $d100 -le 5 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 8) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 10 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy fog $time_string.** (Can't see further than 5 feet. Targets further than 5 feet away have Concealment)"
        elif [ $d100 -le 30 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy rain $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
        elif [ $d100 -le 60 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 12) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is heavy rain $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
        elif [ $d100 -le 80 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 2 6) ))
            time_string=$(bash time-string.sh $time $stop)
            if [ $temp -lt 40 ]; then
                echo "**There is sleet $time_string.** (3/4 visibility. -2 penalty on Perception and Ranged Attacks. 75% chance each hour to extinguish unprotected flames.)"
            else
                echo "**There is heavy rain $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
            fi
        elif [ $d100 -le 90 ]; then
            stop=$(( $time + $(bash n-dice-x.sh 1 3) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a thunderstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames. )"
        else
            stop=$(( $time + $(bash n-dice-x.sh 1 6) ))
            time_string=$(bash time-string.sh $time $stop)
            echo "**There is a thunderstorm $time_string.** (1/4 visibility. -6 penalty on Perception and Ranged Attacks. Extinguishes unprotected flames.)"
        fi
    fi
fi