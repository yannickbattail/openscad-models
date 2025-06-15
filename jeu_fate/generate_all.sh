#!/bin/bash

npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 2,2 -j 15 --configFile fate.config.json ./fate.scad
