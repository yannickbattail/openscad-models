#!/bin/bash
#set -x

# beep.sh
# Usage: beep.sh [DURATION_IN_SECONDS] [FREQUENCY] [VOLUME]
# ex:
# beep.sh 2
# beep.sh 0.3 440 0.5

# Requirements: command 'play' from package 'sox'

duration="1"
frequency="440"
volume="0.9"
if [[ ! -z "$1" ]]
then
  duration=$1
fi
if [[ ! -z "$2" ]]
then
  frequency=$2
fi
if [[ ! -z "$3" ]]
then
  volume=$3
fi

play -q -n synth $duration sin $frequency vol $volume 2> /dev/null
