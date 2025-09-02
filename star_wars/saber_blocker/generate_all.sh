#!/bin/bash

parallelJobs=10
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --parallelJobs $parallelJobs --configFile saber_blocker.yaml ./saber_blocker.scad
