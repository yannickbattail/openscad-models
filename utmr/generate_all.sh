#!/bin/bash

parallelJobs=14
outFormats="png,webp,3mf"

npx openscad-generate@latest generate --outFormats ${outFormats} --parallelJobs ${parallelJobs} --configFile utmr.yaml ./utmr.scad
