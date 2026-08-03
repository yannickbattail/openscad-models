#!/bin/bash

parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

npx openscad-generate@latest generate --parallelJobs $parallelJobs --configFile etoile_et_foudre.yaml ./etoile_et_foudre.scad
status=$?

# Notify user about the result
if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "openscad-generate" "Generation of etoile_et_foudre finished successfully."
  else
    notify-send -u critical "openscad-generate" "Generation of etoile_et_foudre FAILED with exit code $status."
  fi
else
  # Fallback to stdout if notify-send isn't available
  if [ $status -eq 0 ]; then
    echo "[INFO] Generation of etoile_et_foudre finished successfully."
  else
    echo "[ERROR] Generation of etoile_et_foudre FAILED with exit code $status." >&2
  fi
fi

exit $status

