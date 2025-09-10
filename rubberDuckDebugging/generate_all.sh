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

npx openscad-generate@latest generate --mosaicFormat ${mosaicColumns},${mosaicLines} --parallelJobs ${parallelJobs} --configFile RubberDuckDebugging.yaml ./RubberDuckDebugging.scad
