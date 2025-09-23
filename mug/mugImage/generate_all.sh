#!/bin/bash

set -e # Exit on error

parallelJobs=14
outFormats=png,webp,binstl
#outFormats=binstl

# it takes a loooong time (and cpu, and memory) to generate
# so it is better to generate only the model (ParameterSet) you want
onlyParamSet=''
onlyParamSet='-p tikawahukwa'

parallelJobs=2
if command -v nproc >/dev/null 2>&1; then # check if the command nproc exists
  parallelJobs=$(nproc --ignore=2)
fi
if ! [[ "$parallelJobs" =~ ^[1-9][0-9]*$ ]]; then # Validate that parallelJobs is a positive integer
  parallelJobs=2
fi

npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 4,4 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml $onlyParamSet ./mugImage.scad
