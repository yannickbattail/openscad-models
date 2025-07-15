#!/bin/bash

parallel_jobs=10

npx openscad-generate@latest generate -j $parallel_jobs --outFormats png,webp,3mf --mosaicFormat 6,6 --configFile dice_animal.yaml ./dice_animal.scad
