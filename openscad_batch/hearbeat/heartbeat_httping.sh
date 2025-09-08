#!/bin/bash
#set -x

# heartbeat_httping.sh
# Usage: heartbeat_httping.sh URI
# stop it with ctrl+c
# ex:
# heartbeat_httping.sh http://perdu.com
# heartbeat_httping.sh https://192.168.1.1:8080

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
  echo "Usage: $0 URI" >&2
  exit 1
fi

cmd="httping -t 1 -c 1 $cmdOpt"

echo ./heartbeat.sh $heartbeatOpt $cmd
./heartbeat.sh $heartbeatOpt $cmd
