#!/bin/bash

npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 2,3 -j 15 --configFile fate.json5 ./fate.scad
npx openscad-generate@latest generate --outFormats png,webp,3mf --mosaicFormat 4,3 -j 15 --configFile set_de_jeu.json5 ./set_de_jeu.scad
