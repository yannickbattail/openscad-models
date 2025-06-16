#!/bin/bash

npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 2,2 -j 15 --configFile fate.config.json ./fate.scad
npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 4,3 -j 15 --configFile set_de_jeu.config.json ./set_de_jeu.scad
