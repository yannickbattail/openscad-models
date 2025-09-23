#!/bin/bash

parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

npx openscad-generate@latest generate --outFormats 3mf --parallelJobs $parallelJobs --configFile CD_solar_oven.yaml ./CD_solar_oven.scad
status=$?

# Notify user about the result
if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "openscad-generate" "Generation of CD_solar_oven finished successfully."
  else
    notify-send -u critical "openscad-generate" "Generation of CD_solar_oven FAILED with exit code $status."
  fi
else
  # Fallback to stdout if notify-send isn't available
  if [ $status -eq 0 ]; then
    echo "[INFO] Generation of CD_solar_oven finished successfully."
  else
    echo "[ERROR] Generation of CD_solar_oven FAILED with exit code $status." >&2
  fi
fi

npx openscad-generate@latest generate -p all_debug_squareMeter   --outFormats png,webp --parallelJobs $parallelJobs --configFile CD_solar_oven.yaml ./CD_solar_oven.scad
npx openscad-generate@latest generate -p base                    --outFormats png,webp,3mf --parallelJobs $parallelJobs --configFile CD_solar_oven.yaml ./CD_solar_oven.scad
npx openscad-generate@latest generate -p support_squareMeter_A1  --outFormats png,webp --parallelJobs $parallelJobs --configFile CD_solar_oven.yaml ./CD_solar_oven.scad

exit $status

