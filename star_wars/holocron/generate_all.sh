#!/bin/bash

parallelJobs=10
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --mosaicFormat 3,2  --parallelJobs $parallelJobs --configFile holocron_box.yaml ./holocron_box.scad
