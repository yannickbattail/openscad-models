#!/bin/bash

parallelJobs=10

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 --parallelJobs $parallelJobs --configFile cthulhu-lightsaber.yaml ./cthulhu-lightsaber.scad
