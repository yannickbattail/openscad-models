#!/bin/bash
#set -x

# heartbeat_file.sh
# Usage: heartbeat_file.sh file
# stop it with ctrl+c
# ex:
# heartbeat_file.sh service.lock
# heartbeat_file.sh file.log

heartbeatOpt=""
cmdOpt=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -*|--*)
      heartbeatOpt="${heartbeatOpt} $1 $2"
      shift # past argument
      shift # past value
      ;;
    *)
      cmdOpt="$@"
      POSITIONAL_ARGS+=("$1") # save positional arg
      break
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [ "$#" -ne 1 ]
then
  echo "Error: $0 take 1 parameter" >&2
  echo "Usage: $0 file" >&2
  exit 1
fi

cmd="head -c 0 $cmdOpt"

#echo ./heartbeat.sh $heartbeatOpt $cmd
./heartbeat.sh $heartbeatOpt $cmd
