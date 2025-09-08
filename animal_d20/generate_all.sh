#!/bin/bash

parallel_jobs=10

npx openscad-generate@latest generate -j $parallel_jobs --outFormats png,webp,3mf --mosaicFormat 5,3 --configFile animal_d20.yaml ./animal_d20.scad
