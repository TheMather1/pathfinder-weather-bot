#!/usr/bin/env bash
case ${1} in
    0) echo "**It is almost completely windstill.**";;
    1) echo "**There's a comfortable breeze.**";;
    2) echo "**There's a notable wind. **(Creatures of size Tiny or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Ranged weapon attacks and Skill checks affected by wind take a -2 penalty.)";;
    3) echo "**There's a strong wind. **(Creatures of size Siny or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Creatures of size Tiny or smaller are at risk of being blown away. Ranged weapon attacks and Skill checks affected by wind take a -4 penalty.)";;
    4) echo "**There's a storm. **(Creatures of size Medium or smaller have to succeed at a DC 10 Strength check to walk, or a DC 20 Fly check to fly headwind. Creatures of size Small or smaller are at risk of being blown away. Skill checks affected by wind take a -8 Penalty. Ranged weapon attacks are impossible and ranged siege attacks take a -4 penalty.)";;
esac