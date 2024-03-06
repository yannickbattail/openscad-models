#!/bin/bash
#set -x

# heartbeat_ping.sh
# Usage: heartbeat_ping.sh IP_or_HOSTNAME_to_ping
# stop it with ctrl+c
# ex:
# heartbeat_ping.sh perdu.com
# heartbeat_ping.sh 192.168.1.1

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
  echo "Usage: $0 IP_or_HOSTNAME_to_ping" >&2
  exit 1
fi

cmd="ping -t 1 -c 1 $cmdOpt"

echo ./heartbeat.sh $heartbeatOpt $cmd
./heartbeat.sh $heartbeatOpt $cmd
