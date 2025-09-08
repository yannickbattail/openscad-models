#!/bin/bash
#set -x

# hartbeat.sh
# Usage: hartbeat.sh cmd
# stop it with ctrl+c
# ex:
# hartbeat.sh ping -w 1 -c 1 192.168.1.1
# hartbeat.sh ping -w 1 -c 1 perdu.com
# hartbeat.sh httping -t 1 -c 1 http://perdu.com
# hartbeat.sh head -c 0 somefile
# hartbeat.sh ps -p $PID

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
  echo "Script for generating 3D files, images and animations from an openscad file and a parameter file." >&2
  echo "Usage: $0 [OPTION]... OPENSCAD_FILE" >&2
  echo "-c, --config-file configuration_file      specify another configuration file than the default \${OPENSCAD_FILE}.conf." >&2
  echo "-p, --only-parameter-set parameter-set    parameter-set is one the parameter-set name present in the file." >&2
  echo "-g, --generate only_generate              only_generate must be one or multiple separated by ',' of these values: jpg,gif,webp,stl,obj,3mf,wrl,off,amf,conf. By default it will generate jpg,gif,stl." >&2
  echo "--f3d                                     use f3d for images generation" >&2
  echo "--debug what_to_debug                     debug mode: what_to_debug must be one or multiple separated by ',' of these values: CMD,OUT" >&2
  echo "OPENSCAD_FILE                             path of the openscad file." >&2
  echo "" >&2
  echo "Requirements: command 'jq', 'webp' and 'imagemagick' for gif and mosaic generation"
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
  ./beep.sh 0.2 $volume &
}
longBeep() {
  echo -n e
  ./beep.sh 1 $volume &
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

logFile=/dev/null
actOk=bip
actFail=beeeep
cmd="$@"

while [[ $# -gt 0 ]]; do
  case $1 in
    -l|--log-file)
      logFile="$2"
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
