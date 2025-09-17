#!/bin/bash

mosaicLines=2
mosaicColumns=2

# it takes a loooong time (and cpu, and memory) to generate
# so it is better to generate only the model (ParameterSet) you want
onlyParamSet=''
#onlyParamSet='-p tikawahukwa'

parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

echo "use ${parallelJobs} parallel jobs"

npx openscad-generate@latest generate --mosaicFormat ${mosaicColumns},${mosaicLines} --parallelJobs $parallelJobs ${onlyParamSet} --configFile mugImage.yaml ./mugImage.scad
status=$?

# Notify user about the result
if command -v notify-send >/dev/null 2>&1; then
  if [ $status -eq 0 ]; then
    notify-send -u normal "openscad-generate" "Generation of testing finished successfully."
  else
    notify-send -u critical "cthulhu-lightsaber" "Generation of testing FAILED with exit code $status."
  fi
else
  # Fallback to stdout if notify-send isn't available
  if [ $status -eq 0 ]; then
    echo "[INFO] Generation of testing finished successfully."
  else
    echo "[ERROR] Generation of testing FAILED with exit code $status." >&2
  fi
fi

exit $status

