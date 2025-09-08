#!/bin/bash

parallelJobs=10
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --mosaicFormat 3,3 --parallelJobs $parallelJobs --configFile selfie_saber.yaml ./selfie_saber.scad
