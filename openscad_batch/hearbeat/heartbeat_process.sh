#!/bin/bash
#set -x

# heartbeat_process.sh
# Usage: heartbeat_process.sh process_id
# stop it with ctrl+c
# ex:
# heartbeat_process.sh 42666
# ex:
# sleep 10 & ### or other cmd with a & at the end
# pid=$!
# heartbeat_process.sh $pid 

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

cmd="ps -p $cmdOpt"

echo ./heartbeat.sh $heartbeatOpt $cmd
./heartbeat.sh $heartbeatOpt $cmd
