#!/bin/bash

paralel_jobs=15

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 -j ${paralel_jobs} --configFile globalConfig.yaml ./figurine.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 5,4 -j ${paralel_jobs} --configFile globalConfig.yaml ./fate.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 4,3 -j ${paralel_jobs} --configFile globalConfig.yaml ./set_de_jeu.scad
