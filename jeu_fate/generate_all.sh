#!/bin/bash

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 5,4 -j 15 --configFile fate.yaml ./fate.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 4,3 -j 15 --configFile set_de_jeu.yaml ./set_de_jeu.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,2 -j 15 --configFile figurine.yaml ./figurine.scad
