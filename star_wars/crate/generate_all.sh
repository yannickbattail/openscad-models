#!/bin/bash

npx openscad-generate generate --outFormats png,webp,3mf --mosaicFormat 2,2 --configFile sw-crate.config.json5 ./sw-crate.scad
