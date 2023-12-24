#!/bin/bash
#set -x

# beep.sh
# Usage: beep.sh [DURATION_IN_SECONDS] [VOLUME]
# ex:
# beep.sh 2
# beep.sh 0.3

duration="1"
volume="0.9"
if [[ ! -z "$1" ]]
then
  duration=$1
fi
if [[ ! -z "$2" ]]
then
  volume=$2
fi

play -q -n synth $duration sin 440 vol $volume 2> /dev/null
