#!/bin/bash

parallelJobs=10
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --mosaicFormat 2,2  --parallelJobs $parallelJobs --configFile sw-crate.yaml ./sw-crate.scad
