#!/bin/bash

outFormats="png,webp,3mf"
mosaicLines=4
mosaicColumns=4
parallelJobs=$(nproc --ignore=2)
echo use ${parallelJobs} parallel jobs

npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat ${mosaicColumns},${mosaicLines} --parallelJobs ${parallelJobs} --configFile RubberDuckDebugging.yaml ./RubberDuckDebugging.scad
