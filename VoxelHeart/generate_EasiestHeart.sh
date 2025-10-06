#!/bin/bash

mosaicLines=2
mosaicColumns=2
parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

notify-success() {
  "$@"
  local status=$?
  if command -v notify-send >/dev/null 2>&1; then
    if [ $status -eq 0 ]; then
      notify-send -u normal "openscad-generate" "Generation of EasiestHeart finished successfully."
    else
      notify-send -u critical "openscad-generate" "Generation of EasiestHeart FAILED with exit code $status."
    fi
  else
    if [ $status -eq 0 ]; then
      echo "[INFO] Generation of EasiestHeart finished successfully."
    else
      echo "[ERROR] Generation of EasiestHeart FAILED with exit code $status." >&2
    fi
  fi
  return $status
}

notify-success npx openscad-generate@latest generate --mosaicFormat ${mosaicColumns},${mosaicLines} --parallelJobs $parallelJobs --configFile EasiestHeart.yaml ./EasiestHeart.scad
exit $?
