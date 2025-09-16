#!/bin/bash

mosaicLines=4
mosaicColumns=4
parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

npx openscad-generate@latest generate --mosaicFormat ${mosaicColumns},${mosaicLines} --parallelJobs $parallelJobs --configFile cthulhu-lightsaber.yaml ./cthulhu-lightsaber.scad
status=$?

# Notify user about the result
if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "openscad-generate" "Generation of cthulhu-lightsaber finished successfully."
  else
    notify-send -u critical "openscad-generate" "Generation of cthulhu-lightsaber FAILED with exit code $status."
  fi
else
  # Fallback to stdout if notify-send isn't available
  if [ $status -eq 0 ]; then
    echo "[INFO] Generation of cthulhu-lightsaber finished successfully."
  else
    echo "[ERROR] Generation of cthulhu-lightsaber FAILED with exit code $status." >&2
  fi
fi

exit $status

