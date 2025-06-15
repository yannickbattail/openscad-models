#!/bin/bash

parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

npx openscad-generate@latest generate --mosaicFormat 2,2  --parallelJobs $parallelJobs --configFile globalConfig.yaml ./figurine.scad
#npx openscad-generate@latest generate --mosaicFormat 5,4  --parallelJobs $parallelJobs --configFile globalConfig.yaml ./fate.scad
#npx openscad-generate@latest generate --mosaicFormat 4,3  --parallelJobs $parallelJobs --configFile globalConfig.yaml ./set_de_jeu.scad
status=$?

# Notify user about the result
if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "jeu fate" "Generation finished successfully."
  else
    notify-send -u critical "jeu fate" "Generation FAILED with exit code $status."
  fi
else
  # Fallback to stdout if notify-send isn't available
  if [ $status -eq 0 ]; then
    echo "[INFO] Generation finished successfully."
  else
    echo "[ERROR] Generation FAILED with exit code $status." >&2
  fi
fi

exit $status

