#!/bin/bash
#set -x

# hartbeat_file.sh
# Usage: hartbeat_file.sh file
# stop it with ctrl+c
# ex:
# hartbeat_file.sh service.lock
# hartbeat_file.sh file.log

hartbeatOpt=""
cmdOpt=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -*|--*)
      hartbeatOpt="${hartbeatOpt} $1 $2"
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

cmd="head -c 0 $cmdOpt"

echo ./hartbeat.sh $hartbeatOpt $cmd
./hartbeat.sh $hartbeatOpt $cmd
