#!/bin/bash
#set -x

# heartbeat.sh
# Usage: heartbeat.sh cmd
# stop it with ctrl+c
# ex:
# heartbeat.sh ping -w 1 -c 1 192.168.1.1
# heartbeat.sh ping -w 1 -c 1 perdu.com
# heartbeat.sh httping -t 1 -c 1 http://perdu.com
# heartbeat.sh head -c 0 somefile
# heartbeat.sh ps -p $PID

# colors
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
IReset='\e[0m'            # Reset colors

POSITIONAL_ARGS=()
usage() {
  echo -ne "$IBlue"
  echo "Script that play a heartbeat like an electrocardiogram when command success or fail" >&2
  echo "Usage: $0 [OPTION] COMMAND" >&2
  echo "-l, --log-file log_file                   log file for the output of the command." >&2
  echo "-f, --frequency_note frequency            frequency of the bip in Hz" >&2
  echo "-v, --volume bip_volume                   volume of the bip between 0 and 1" >&2
  echo "--ok bip|beeeep|noop                      action to do when the command is successful: bip (plays a short bip, beeeep (plays a long beep), noop or else (do nothing)" >&2
  echo "--fail bip|beeeep|noop                      action to do when the command fails: bip (plays a short bip, beeeep (plays a long beep), noop or else (do nothing)" >&2
  echo "COMMAND                                   command to be executed, if the command return 0 (success) short bip is played else long beeeep is played" >&2
  echo "" >&2
  echo "Requirements: command 'play' from package 'sox'" >&2
  echo "" >&2
  echo "ex:" >&2
  echo "heartbeat.sh ping -w 1 -c 1 192.168.1.1" >&2
  echo "heartbeat.sh ping -w 1 -c 1 perdu.com" >&2
  echo "heartbeat.sh httping -t 1 -c 1 http://perdu.com" >&2
  echo "heartbeat.sh head -c 0 somefile" >&2
  echo "heartbeat.sh ps -p \$PID" >&2
  echo "stop it with ctrl+c" >&2
  echo -ne "$IReset"
}

echo_log() {
  echo -ne "$ICyan"
  echo "$@"
  echo -ne "$IReset"
}

echo_info() {
  echo -ne "$IGreen"
  echo "$@"
  echo -ne "$IReset"
}

echo_warn() {
  echo -ne "$IPurple"
  echo "$@"
  echo -ne "$IReset"
}

echo_error() {
  echo -ne "$IRed" >&2
  echo "$@" >&2
  usage
  echo -ne "$IReset" >&2
  exit 1
}

shortBeep() {
  echo -n ep be
  ./beep.sh 0.2 $frequency_note $volume &
}

longBeep() {
  echo -n e
  ./beep.sh 1 $frequency_note $volume &
}

playBeep() {
  if [[ $1 == "bip" ]]
  then
    shortBeep
  elif [[ $1 == "beeeep" ]]
  then
    longBeep
  fi
}

execCmd() {
  $@ >> $logFile 2>&1
  ret=$?
  # cmdPid=$!
  # (sleep 1 ; kill -9 $cmdPid  > /dev/null 2> /dev/null) &
  return $ret
}

if ! [ -x "$(command -v play)" ]
then
  echo 'Error: play is not installed.' >&2
  echo 'You can install it with the command: apt install sox' >&2
  exit 1
fi

volume=0.9
frequency_note=440

logFile=/dev/null
actOk=bip
actFail=beeeep
cmd="$@"

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -l|--log-file)
      logFile="$2"
      shift # past argument
      shift # past value
      ;;
    -f|--frequency_note)
      frequency_note="$2"
      shift # past argument
      shift # past value
      ;;
    -v|--volume)
      volume="$2"
      shift # past argument
      shift # past value
      ;;
    --ok)
      actOk="$2"
      shift # past argument
      shift # past value
      ;;
    --fail)
      actFail="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo_error "unknown option: $1"
      ;;
    *)
      cmd="$@"
      POSITIONAL_ARGS+=("$1") # save positional arg
      break
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ $cmd == "" ]]
then
    echo_error "no command specified"
fi

echo -n be
while true
do 
  execCmd $cmd
  if [ $? -eq 0 ]
  then
    playBeep $actOk
  else
    playBeep $actFail
  fi
  sleep 1
done
