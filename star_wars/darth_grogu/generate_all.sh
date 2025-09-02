#!/bin/bash

parallelJobs=14
outFormats=png,webp,3mf

npx openscad-generate@latest generate --outFormats $outFormats --mosaicFormat 3,3  --parallelJobs $parallelJobs --configFile darth_maul_horns.yaml ./darth_maul_horns.scad

npx openscad-generate@latest generate --outFormats $outFormats --parallelJobs $parallelJobs --configFile darth_grogu.yaml ./darth_grogu.scad
