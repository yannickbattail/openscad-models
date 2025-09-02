#!/bin/bash

parallelJobs=14
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --mosaicFormat 3,2  --parallelJobs $parallelJobs --configFile grogu.yaml ./grogu.scad
