#!/bin/bash

parallelJobs=14
outFormats="png,webp,3mf"

npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 1,2 --parallelJobs ${parallelJobs} --configFile EasiestHeart.yaml ./EasiestHeart.scad
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,2 --parallelJobs ${parallelJobs} --configFile VoxelHeart.yaml ./VoxelHeart.scad
## this after because it needs gen/VoxelHeart_VoxelHeart1_hull.3mf
npx openscad-generate@latest generate --outFormats ${outFormats} --mosaicFormat 2,3 --parallelJobs ${parallelJobs} --configFile heartJewel.yaml ./heartJewel.scad
