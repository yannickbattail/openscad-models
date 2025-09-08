#!/bin/bash

npx openscad-generate@latest generate -j 14 --outFormats png,webp,3mf --mosaicFormat 4,3 --configFile dice_animal.yaml ./dice_animal.scad
