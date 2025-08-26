#!/bin/bash

set -e # Exit on error

parallelJobs=14
outFormats=png,webp,binstl
#outFormats=binstl

# it takes a loooong time (and cpu, and memory) to generate
# so it is better to generate only the model (ParameterSet) you want
onlyParamSet=''
#onlyParamSet='-p savoie'

npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 4,4 --parallelJobs ${parallelJobs} --configFile ../globalConfig.yaml $onlyParamSet ./mugImage.scad
