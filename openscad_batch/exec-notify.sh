#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <command>"
  exit 1
fi

"$@"
return_code=$?

if [ $return_code -ne 0 ]; then
  notify-send --urgency=normal --expire-time=5000 --app-name=exec-notify "Command failed!" "Command '$*' failed with code $return_code"
  exit $return_code
else
  notify-send --urgency=low --expire-time=3000 --app-name=exec-notify "Command complete!" "Command '$*' finished successfully!"
fi
