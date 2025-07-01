#!/bin/bash

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 3,3 --configFile dice_animal.yaml ./dice_animal.scad
